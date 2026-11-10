package com.group.antian.module.system.service.dashboard;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.group.antian.framework.common.pojo.PageParam;
import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.tenant.core.context.TenantContextHolder;
import com.group.antian.module.system.controller.admin.dashboard.vo.ManagementActivityReqVO;
import com.group.antian.module.system.dal.dataobject.dept.DeptDO;
import com.group.antian.module.system.dal.dataobject.user.AdminUserDO;
import com.group.antian.module.system.dal.dataobject.permission.RoleDO;
import com.group.antian.module.system.dal.dataobject.permission.UserRoleDO;
import com.group.antian.module.system.dal.mysql.dept.DeptMapper;
import com.group.antian.module.system.dal.mysql.user.AdminUserMapper;
import com.group.antian.module.system.dal.mysql.permission.RoleMapper;
import com.group.antian.module.system.dal.mysql.permission.UserRoleMapper;
import com.group.antian.module.system.dal.mysql.logger.OperateLogMapper;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import java.time.LocalDate;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ManagementDashboardServiceTest {
    @InjectMocks private ManagementDashboardService service;
    @Mock private AdminUserMapper users;
    @Mock private DeptMapper depts;
    @Mock private RoleMapper roles;
    @Mock private UserRoleMapper links;
    @Mock private OperateLogMapper logs;

    @BeforeEach void tenant() { TenantContextHolder.setTenantId(166L); }
    @AfterEach void clear() { TenantContextHolder.clear(); }

    @Test void overviewCountsOnlyEnabledVisibleUsersAndBuildsSubtreeTotals() {
        when(users.selectList(any(Wrapper.class))).thenReturn(List.of(user(1, 11L, 0), user(2, 12L, 0), user(3, 12L, 1)));
        when(depts.selectList(any(Wrapper.class))).thenReturn(List.of(dept(10, 0), dept(11, 10), dept(12, 11), dept(20, 0)));
        when(roles.selectList(any(Wrapper.class))).thenReturn(List.of(role(100)));
        when(links.selectList(any(Wrapper.class))).thenReturn(List.of(link(1, 100)));
        var result = service.getOverview();
        assertEquals(2, result.getUserCount());
        assertEquals(4, result.getDeptCount());
        assertEquals(1, result.getRoleCount());
        assertEquals(1, result.getCompanyCount());
        assertEquals(1, result.getUnassignedCount());
        assertEquals(2, result.getOrganizations().get(0).getMemberCount());
        assertEquals(2, result.getOrganizations().get(0).getDeptCount());
        assertEquals(1, result.getOrganizations().get(0).getChildren().get(0).getDirectMemberCount());
        assertEquals(List.of("role100"), result.getMembers().get(0).getRoles());
        assertEquals(List.of(), result.getMembers().get(1).getRoles());
        verifyScopeAndProjection(users);
    }

    @Test void emptyTenantDoesNotIssueUnboundedAssociationQuery() {
        when(users.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(depts.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(roles.selectList(any(Wrapper.class))).thenReturn(List.of());
        var result = service.getOverview();
        assertEquals(0, result.getUserCount());
        assertEquals(0, result.getCompanyCount());
        assertTrue(result.getOrganizations().isEmpty());
        verifyNoInteractions(links, logs);
    }

    @Test void orphanDepartmentsAndCyclesAreIncludedOnceWithoutRecursionFailure() {
        when(users.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(roles.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(depts.selectList(any(Wrapper.class))).thenReturn(List.of(dept(10, 11), dept(11, 10), dept(20, 99)));
        var result = service.getOverview();
        assertEquals(2, result.getOrganizations().size());
        assertEquals(3, result.getDeptCount());
        assertEquals(1, result.getOrganizations().get(1).getChildren().size());
    }

    @Test void accountStatisticsUseBoundParametersVisibleIdsAndInclusiveEndDate() {
        var person = user(1, 10L, 0);
        when(users.selectList(any(Wrapper.class))).thenReturn(List.of(person));
        when(roles.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(users.selectCount(any(Wrapper.class))).thenReturn(1L);
        when(logs.selectCount(any(Wrapper.class))).thenReturn(0L);
        when(users.selectPage(any(PageParam.class), any(Wrapper.class))).thenReturn(new PageResult<>(List.of(person), 1L));
        var query = query();
        query.setKeyword("user1");
        var result = service.getActivity(query);
        assertEquals(1, result.getOpened());
        assertEquals(1, result.getPage().getTotal());
        assertEquals("person1（user1）", result.getPage().getList().get(0).getSubject());
        ArgumentCaptor<Wrapper<AdminUserDO>> capture = ArgumentCaptor.forClass(Wrapper.class);
        verify(users).selectCount(capture.capture());
        var wrapper = (QueryWrapper<AdminUserDO>) capture.getValue();
        String sql = wrapper.getSqlSegment();
        assertTrue(sql.contains("tenant_id ="));
        assertTrue(sql.contains("create_time <"));
        assertTrue(wrapper.getParamNameValuePairs().containsValue(LocalDate.of(2026, 11, 11).atStartOfDay()));
        assertTrue(wrapper.getParamNameValuePairs().containsValue(166L));
        assertFalse(wrapper.getSqlSelect().contains("password"));
        assertEquals("id", wrapper.getSqlSelect(), "COUNT 只接受单列投影，不能复用多列明细投影");
    }

    @Test void keywordWithoutMatchesNeverQueriesAllUsers() {
        when(users.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(roles.selectList(any(Wrapper.class))).thenReturn(List.of());
        when(users.selectCount(any(Wrapper.class))).thenReturn(0L);
        when(logs.selectCount(any(Wrapper.class))).thenReturn(0L);
        when(users.selectPage(any(PageParam.class), any(Wrapper.class))).thenReturn(new PageResult<>(List.of(), 0L));
        var query = query();
        query.setKeyword("' OR 1=1 --");
        service.getActivity(query);
        ArgumentCaptor<Wrapper<AdminUserDO>> capture = ArgumentCaptor.forClass(Wrapper.class);
        verify(users).selectCount(capture.capture());
        var wrapper = (QueryWrapper<AdminUserDO>) capture.getValue();
        assertTrue(wrapper.getSqlSegment().contains("id IN"));
        assertTrue(wrapper.getParamNameValuePairs().containsValue(-1L));
        assertFalse(wrapper.getSqlSegment().contains("OR 1=1"));
        verifyNoInteractions(links);
    }

    @Test void rejectsUnboundedOrReversedDateAndPageRanges() {
        var query = query();
        assertTrue(query.isDateRangeValid());
        assertTrue(query.isPageSizeValid());
        query.setEndDate(query.getStartDate().minusDays(1));
        assertFalse(query.isDateRangeValid());
        query.setEndDate(query.getStartDate().plusDays(367));
        assertFalse(query.isDateRangeValid());
        query.setPageSize(-1);
        assertFalse(query.isPageSizeValid());
        query.setPageSize(101);
        assertFalse(query.isPageSizeValid());
    }

    private void verifyScopeAndProjection(AdminUserMapper mapper) {
        ArgumentCaptor<Wrapper<AdminUserDO>> capture = ArgumentCaptor.forClass(Wrapper.class);
        verify(mapper).selectList(capture.capture());
        var wrapper = (QueryWrapper<AdminUserDO>) capture.getValue();
        wrapper.getSqlSegment();
        assertTrue(wrapper.getParamNameValuePairs().containsValue(166L));
        assertFalse(wrapper.getSqlSelect().contains("password"));
        assertFalse(wrapper.getSqlSelect().contains("mobile"));
    }
    private static ManagementActivityReqVO query() {
        var query = new ManagementActivityReqVO();
        query.setStartDate(LocalDate.of(2026, 11, 1));
        query.setEndDate(LocalDate.of(2026, 11, 10));
        return query;
    }
    private static AdminUserDO user(long id, Long dept, int status) {
        var user = new AdminUserDO();
        user.setId(id); user.setDeptId(dept); user.setStatus(status);
        user.setNickname("person" + id); user.setUsername("user" + id);
        return user;
    }
    private static DeptDO dept(long id, long parent) {
        var dept = new DeptDO(); dept.setId(id); dept.setParentId(parent); dept.setName("dept" + id); return dept;
    }
    private static RoleDO role(long id) {
        var role = new RoleDO(); role.setId(id); role.setName("role" + id); return role;
    }
    private static UserRoleDO link(long user, long role) {
        var link = new UserRoleDO(); link.setUserId(user); link.setRoleId(role); return link;
    }
}
