package com.group.antian.module.system.framework.security.core;

import com.group.antian.framework.common.enums.UserTypeEnum;
import com.group.antian.framework.security.core.LoginUser;
import com.group.antian.framework.security.core.util.SecurityFrameworkUtils;
import com.group.antian.framework.tenant.core.util.TenantUtils;
import com.group.antian.module.system.enums.permission.RoleCodeEnum;
import com.group.antian.module.system.service.permission.PermissionService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;

import java.util.Objects;

/**
 * 运营平台租户管理权限，不受访问租户切换和普通租户角色授权影响。
 */
@Component("tenantManagement")
public class TenantManagementPermission {

    /** 系统初始化的运营平台租户。 */
    private static final Long PLATFORM_TENANT_ID = 1L;

    @Resource
    private PermissionService permissionService;

    public boolean canQueryTenants() {
        return hasPlatformTenantPermission("system:tenant:query");
    }

    public boolean canCreateTenants() {
        return hasPlatformTenantPermission("system:tenant:create");
    }

    public boolean canUpdateTenants() {
        return hasPlatformTenantPermission("system:tenant:update");
    }

    public boolean canDeleteTenants() {
        return hasPlatformTenantPermission("system:tenant:delete");
    }

    public boolean canExportTenants() {
        return hasPlatformTenantPermission("system:tenant:export");
    }

    /** 按原始平台身份和实际操作权限校验，访问租户切换不能跳过授权。 */
    private boolean hasPlatformTenantPermission(String permission) {
        LoginUser user = SecurityFrameworkUtils.getLoginUser();
        if (!isPlatformUser(user)) {
            return false;
        }
        return TenantUtils.execute(user.getTenantId(), () ->
                permissionService.hasAnyPermissions(user.getId(), permission));
    }

    public boolean isPlatformAdmin() {
        LoginUser user = SecurityFrameworkUtils.getLoginUser();
        if (!isPlatformUser(user)) {
            return false;
        }
        // 按原始登录身份校验角色；跨租户访问不能跳过此校验。
        return TenantUtils.execute(user.getTenantId(), () ->
                permissionService.hasAnyRoles(user.getId(), RoleCodeEnum.SUPER_ADMIN.getCode()));
    }

    private static boolean isPlatformUser(LoginUser user) {
        return user != null && Objects.equals(user.getTenantId(), PLATFORM_TENANT_ID)
                && Objects.equals(user.getUserType(), UserTypeEnum.ADMIN.getValue());
    }

}
