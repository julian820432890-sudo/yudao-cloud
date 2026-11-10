package com.group.antian.module.system.framework.security.core;

import com.group.antian.framework.security.core.service.SecurityFrameworkService;
import com.group.antian.module.system.controller.admin.dashboard.ManagementDashboardController;
import com.group.antian.module.system.controller.admin.dashboard.vo.ManagementActivityReqVO;
import com.group.antian.module.system.service.dashboard.ManagementDashboardService;
import com.group.antian.module.system.dal.mysql.user.AdminUserMapper;
import com.group.antian.module.system.dal.mysql.dept.DeptMapper;
import com.group.antian.module.system.dal.mysql.permission.RoleMapper;
import com.group.antian.module.system.dal.mysql.permission.UserRoleMapper;
import com.group.antian.module.system.dal.mysql.logger.OperateLogMapper;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import static org.mockito.ArgumentMatchers.*;

@SpringJUnitConfig(ManagementDashboardSecurityTest.Config.class)
class ManagementDashboardSecurityTest {
    @Resource private ManagementDashboardController controller;
    @Resource private SecurityFrameworkService security;
    @Resource private ManagementDashboardService service;

    @BeforeEach void prepare() {
        reset(security, service);
        when(security.hasPermission(anyString())).thenReturn(true);
    }

    @ParameterizedTest
    @ValueSource(strings = {"system:user:query", "system:dept:query", "system:role:query"})
    void overviewRequiresEachUnderlyingReadPermission(String missing) {
        when(security.hasPermission(missing)).thenReturn(false);
        assertThrows(AccessDeniedException.class, controller::getOverview);
        verifyNoInteractions(service);
    }

    @ParameterizedTest
    @ValueSource(strings = {"system:user:query", "system:role:query", "system:operate-log:query"})
    void activityRequiresUserRoleAndAuditReadPermission(String missing) {
        when(security.hasPermission(missing)).thenReturn(false);
        assertThrows(AccessDeniedException.class, () -> controller.getActivity(new ManagementActivityReqVO()));
        verifyNoInteractions(service);
    }

    @Test void readerCanLoadOverviewWithoutPlatformSuperAdministratorRole() {
        assertDoesNotThrow(controller::getOverview);
        verify(service).getOverview();
        verify(security, never()).hasRole(anyString());
    }

    @Configuration
    @EnableMethodSecurity
    static class Config {
        @Bean ManagementDashboardController controller() { return new ManagementDashboardController(); }
        @Bean ManagementDashboardService dashboardService() { return mock(ManagementDashboardService.class); }
        @Bean AdminUserMapper userMapper() { return mock(AdminUserMapper.class); }
        @Bean DeptMapper deptMapper() { return mock(DeptMapper.class); }
        @Bean RoleMapper roleMapper() { return mock(RoleMapper.class); }
        @Bean UserRoleMapper userRoleMapper() { return mock(UserRoleMapper.class); }
        @Bean OperateLogMapper operateLogMapper() { return mock(OperateLogMapper.class); }
        @Bean(name = "ss") SecurityFrameworkService security() { return mock(SecurityFrameworkService.class); }
    }
}
