package com.group.antian.module.system.service.dashboard;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.tenant.core.context.TenantContextHolder;
import com.group.antian.module.system.controller.admin.dashboard.vo.*;
import com.group.antian.module.system.controller.admin.dashboard.vo.ManagementOverviewRespVO.Member;
import com.group.antian.module.system.controller.admin.dashboard.vo.ManagementOverviewRespVO.Organization;
import com.group.antian.module.system.dal.dataobject.dept.DeptDO;
import com.group.antian.module.system.dal.dataobject.user.AdminUserDO;
import com.group.antian.module.system.dal.dataobject.permission.RoleDO;
import com.group.antian.module.system.dal.dataobject.permission.UserRoleDO;
import com.group.antian.module.system.dal.dataobject.logger.OperateLogDO;
import com.group.antian.module.system.dal.mysql.dept.DeptMapper;
import com.group.antian.module.system.dal.mysql.user.AdminUserMapper;
import com.group.antian.module.system.dal.mysql.permission.RoleMapper;
import com.group.antian.module.system.dal.mysql.permission.UserRoleMapper;
import com.group.antian.module.system.dal.mysql.logger.OperateLogMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import static com.group.antian.module.system.enums.LogRecordConstants.SYSTEM_ROLE_TYPE;
import static com.group.antian.module.system.enums.LogRecordConstants.SYSTEM_USER_TYPE;

@Service
public class ManagementDashboardService {
    @Resource private AdminUserMapper userMapper;
    @Resource private DeptMapper deptMapper;
    @Resource private RoleMapper roleMapper;
    @Resource private UserRoleMapper userRoleMapper;
    @Resource private OperateLogMapper operateLogMapper;

    // 不关闭租户或部门数据权限。显式租户条件也保护没有 TenantBaseDO 的关联表和日志表。
    private <T> QueryWrapper<T> scoped() {
        return new QueryWrapper<T>().eq("tenant_id", TenantContextHolder.getRequiredTenantId());
    }

    private List<AdminUserDO> visibleUsers() {
        return userMapper.selectList(this.<AdminUserDO>scoped().select(
                "id", "username", "nickname", "dept_id", "status", "create_time"));
    }

    private List<RoleDO> roles() {
        return roleMapper.selectList(this.<RoleDO>scoped().select("id", "name", "status"));
    }

    private Map<Long, List<String>> roleNames(List<AdminUserDO> users, List<RoleDO> roles) {
        if (users.isEmpty() || roles.isEmpty()) return Map.of();
        Map<Long, String> names = roles.stream().collect(Collectors.toMap(RoleDO::getId, RoleDO::getName));
        var links = userRoleMapper.selectList(this.<UserRoleDO>scoped().select("user_id", "role_id")
                .in("user_id", users.stream().map(AdminUserDO::getId).toList()).in("role_id", names.keySet()));
        Map<Long, List<String>> result = new HashMap<>();
        for (var link : links) {
            result.computeIfAbsent(link.getUserId(), ignored -> new ArrayList<>()).add(names.get(link.getRoleId()));
        }
        return result;
    }

    public ManagementOverviewRespVO getOverview() {
        var users = visibleUsers().stream().filter(user -> Objects.equals(user.getStatus(), 0)).toList();
        var depts = deptMapper.selectList(this.<DeptDO>scoped().select("id", "name", "parent_id", "sort")
                .eq("status", 0).orderByAsc("sort", "id"));
        var roleList = roles();
        var names = roleNames(users, roleList);
        var deptNames = depts.stream().collect(Collectors.toMap(DeptDO::getId, DeptDO::getName));
        var result = new ManagementOverviewRespVO();
        result.setUserCount(users.size());
        result.setDeptCount(depts.size());
        result.setRoleCount(roleList.size());
        for (var user : users) {
            var member = new Member();
            member.setId(user.getId());
            member.setUsername(user.getUsername());
            member.setNickname(user.getNickname());
            member.setDeptId(user.getDeptId());
            member.setDeptName(deptNames.getOrDefault(user.getDeptId(), "未归属启用部门"));
            member.setCreateTime(user.getCreateTime());
            member.setRoles(names.getOrDefault(user.getId(), List.of()).stream().distinct().sorted().toList());
            result.getMembers().add(member);
        }
        result.setUnassignedCount(result.getMembers().stream().filter(member -> member.getRoles().isEmpty()).count());
        var directCounts = users.stream().filter(user -> user.getDeptId() != null)
                .collect(Collectors.groupingBy(AdminUserDO::getDeptId, Collectors.counting()));
        Set<Long> included = new HashSet<>();
        for (var dept : depts) {
            if (!deptNames.containsKey(dept.getParentId())) {
                result.getOrganizations().add(buildOrganization(dept, depts, directCounts, included));
            }
        }
        // 数据异常造成的闭环不应让整个首页无法加载，也不能重复统计同一个部门。
        for (var dept : depts) {
            if (!included.contains(dept.getId())) {
                result.getOrganizations().add(buildOrganization(dept, depts, directCounts, included));
            }
        }
        result.setCompanyCount(result.getOrganizations().isEmpty() ? 0
                : result.getOrganizations().get(0).getChildren().size());
        return result;
    }

    private Organization buildOrganization(DeptDO dept, List<DeptDO> depts,
            Map<Long, Long> directCounts, Set<Long> included) {
        included.add(dept.getId());
        var node = new Organization();
        node.setId(dept.getId());
        node.setName(dept.getName());
        node.setDirectMemberCount(directCounts.getOrDefault(dept.getId(), 0L).intValue());
        node.setMemberCount(node.getDirectMemberCount());
        for (var child : depts) {
            if (Objects.equals(child.getParentId(), dept.getId()) && !included.contains(child.getId())) {
                var childNode = buildOrganization(child, depts, directCounts, included);
                node.getChildren().add(childNode);
                node.setMemberCount(node.getMemberCount() + childNode.getMemberCount());
                node.setDeptCount(node.getDeptCount() + 1 + childNode.getDeptCount());
            }
        }
        return node;
    }

    public ManagementActivityRespVO getActivity(ManagementActivityReqVO req) {
        var users = visibleUsers();
        var names = roleNames(users, roles());
        String keyword = req.getKeyword() == null ? "" : req.getKeyword().trim().toLowerCase(Locale.ROOT);
        var matchingIds = users.stream().filter(user -> keyword.isEmpty()
                || (user.getId() + " " + user.getUsername() + " " + user.getNickname() + " "
                + String.join(" ", names.getOrDefault(user.getId(), List.of()))).toLowerCase(Locale.ROOT).contains(keyword))
                .map(AdminUserDO::getId).toList();
        var opened = this.<AdminUserDO>scoped().select("id", "username", "nickname", "create_time")
                .ge("create_time", req.getStartDate().atStartOfDay())
                .lt("create_time", req.getEndDate().plusDays(1).atStartOfDay())
                .in("id", matchingIds.isEmpty() ? List.of(-1L) : matchingIds);
        var disabled = logQuery(req, users, matchingIds, false);
        var permission = logQuery(req, users, matchingIds, true);
        var result = new ManagementActivityRespVO();
        // selectCount 仅选择主键；复用明细的多列投影会生成 MySQL 不支持的 COUNT(a,b,...)。
        result.setOpened(userMapper.selectCount(opened.clone().select("id")));
        result.setDisabled(operateLogMapper.selectCount(disabled.clone().select("id")));
        result.setPermission(operateLogMapper.selectCount(permission.clone().select("id")));
        if ("opened".equals(req.getCategory())) {
            var page = userMapper.selectPage(req, opened.orderByDesc("create_time", "id"));
            result.setPage(new PageResult<>(page.getList().stream().map(user -> {
                var item = new ManagementActivityRespVO.Item();
                item.setId(user.getId());
                item.setCreateTime(user.getCreateTime());
                item.setSubject(user.getNickname() + "（" + user.getUsername() + "）");
                item.setAction("开通统一用户中心账号");
                item.setOperator("—");
                return item;
            }).toList(), page.getTotal()));
        } else {
            var page = operateLogMapper.selectPage(req,
                    ("disabled".equals(req.getCategory()) ? disabled : permission).orderByDesc("create_time", "id"));
            var userMap = users.stream().collect(Collectors.toMap(AdminUserDO::getId, Function.identity()));
            result.setPage(new PageResult<>(page.getList().stream().map(log -> {
                var item = new ManagementActivityRespVO.Item();
                item.setId(log.getId());
                item.setCreateTime(log.getCreateTime());
                item.setSubject(log.getSubType());
                item.setAction(log.getAction());
                item.setOperator(userMap.containsKey(log.getUserId()) ? userMap.get(log.getUserId()).getNickname()
                        : "用户 #" + log.getUserId());
                return item;
            }).toList(), page.getTotal()));
        }
        return result;
    }

    private QueryWrapper<OperateLogDO> logQuery(ManagementActivityReqVO req, List<AdminUserDO> users,
            List<Long> matchingIds, boolean permission) {
        var visibleIds = users.stream().map(AdminUserDO::getId).toList();
        var ids = visibleIds.isEmpty() ? List.of(-1L) : visibleIds;
        var query = this.<OperateLogDO>scoped().select("id", "user_id", "biz_id", "sub_type", "action", "create_time")
                .eq("user_type", 2).eq("success", true)
                .ge("create_time", req.getStartDate().atStartOfDay())
                .lt("create_time", req.getEndDate().plusDays(1).atStartOfDay());
        if (permission) {
            query.eq("type", SYSTEM_ROLE_TYPE).in("sub_type", "分配用户角色", "分配角色菜单", "分配角色数据权限")
                    .and(q -> q.ne("sub_type", "分配用户角色").or().in("biz_id", ids));
        } else {
            query.eq("type", SYSTEM_USER_TYPE).eq("sub_type", "停用用户").in("biz_id", ids);
        }
        if (req.getKeyword() != null && !req.getKeyword().isBlank()) {
            var matched = matchingIds.isEmpty() ? List.of(-1L) : matchingIds;
            query.and(q -> q.like("action", req.getKeyword().trim()).or().in("biz_id", matched).or().in("user_id", matched));
        }
        return query;
    }
}
