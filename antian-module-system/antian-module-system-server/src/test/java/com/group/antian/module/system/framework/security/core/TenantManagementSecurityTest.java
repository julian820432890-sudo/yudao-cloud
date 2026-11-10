package com.group.antian.module.system.framework.security.core;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.group.antian.framework.common.enums.CommonStatusEnum;
import com.group.antian.framework.common.enums.UserTypeEnum;
import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.security.core.LoginUser;
import com.group.antian.framework.security.core.service.SecurityFrameworkService;
import com.group.antian.framework.tenant.core.context.TenantContextHolder;
import com.group.antian.module.system.controller.admin.tenant.TenantController;
import com.group.antian.module.system.controller.admin.tenant.TenantPackageController;
import com.group.antian.module.system.controller.admin.tenant.vo.packages.TenantPackagePageReqVO;
import com.group.antian.module.system.controller.admin.tenant.vo.packages.TenantPackageSaveReqVO;
import com.group.antian.module.system.controller.admin.tenant.vo.tenant.TenantPageReqVO;
import com.group.antian.module.system.controller.admin.tenant.vo.tenant.TenantSaveReqVO;
import com.group.antian.module.system.dal.dataobject.tenant.TenantDO;
import com.group.antian.module.system.dal.dataobject.tenant.TenantPackageDO;
import com.group.antian.module.system.service.permission.PermissionService;
import com.group.antian.module.system.service.tenant.TenantPackageService;
import com.group.antian.module.system.service.tenant.TenantService;
import jakarta.annotation.Resource;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.mock.web.MockHttpServletResponse;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@SpringJUnitConfig(TenantManagementSecurityTest.Config.class)
class TenantManagementSecurityTest {

    @Resource
    private TenantController tenants;
    @Resource
    private TenantPackageController packages;
    @Resource
    private TenantService tenantService;
    @Resource
    private TenantPackageService packageService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private SecurityFrameworkService security;

    @BeforeEach
    void prepare() {
        reset(tenantService, packageService, permissionService, security);
        // 模拟误授了所有菜单权限，验证平台身份校验仍然生效。
        when(security.hasPermission(anyString())).thenReturn(true);
        when(permissionService.hasAnyRoles(anyLong(), eq("super_admin")))
                .thenAnswer(call -> Objects.equals(call.getArgument(0), 1L));
        when(permissionService.hasAnyPermissions(1L, "system:tenant:query")).thenReturn(true);
    }

    @AfterEach
    void clear() {
        SecurityContextHolder.clearContext();
        TenantContextHolder.clear();
    }

    @ParameterizedTest(name = "{0}, tenant={1}")
    @MethodSource("managementEndpoints")
    void ordinaryTenantCannotAccessManagementEvenWhenVisitingPlatform(
            String name, Long tenantId, Endpoint endpoint) {
        login(110L, tenantId, UserTypeEnum.ADMIN, 1L);
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService, permissionService);
    }

    @ParameterizedTest(name = "platform reader: {0}, visit={1}")
    @MethodSource("queryEndpoints")
    void platformReaderCanQueryWithoutSuperAdminRole(String name, Long visitTenantId, Endpoint endpoint) {
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:query")).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return true;
        });
        when(tenantService.getTenantPage(any())).thenReturn(new PageResult<>(List.of(), 0L));
        when(tenantService.getTenant(122L)).thenReturn(TenantDO.builder().id(122L).build());
        when(tenantService.getTenantListByStatus(anyInt())).thenReturn(List.of());
        when(packageService.getTenantPackageListByStatus(anyInt())).thenReturn(List.of());
        assertDoesNotThrow(() -> endpoint.invoke(tenants, packages));
        verify(permissionService).hasAnyPermissions(285L, "system:tenant:query");
        verify(permissionService, never()).hasAnyRoles(anyLong(), any());
        if (name.equals("package names")) {
            verify(packageService).getTenantPackageListByStatus(CommonStatusEnum.ENABLE.getStatus());
            verifyNoInteractions(tenantService, security);
        } else {
            verifyNoInteractions(packageService, security);
        }
        assertEquals(visitTenantId == null ? 1L : visitTenantId, TenantContextHolder.getTenantId());
    }

    @ParameterizedTest(name = "reader without permission: {0}, visit={1}")
    @MethodSource("queryEndpoints")
    void platformUserCannotQueryWithoutRealPermissionEvenWhenVisitingAnotherTenant(
            String name, Long visitTenantId, Endpoint endpoint) {
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:query")).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return false;
        });
        // ss.hasPermission 已模拟为 true，读接口仍必须通过真实权限查询。
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService, security);
        assertEquals(visitTenantId == null ? 1L : visitTenantId, TenantContextHolder.getTenantId());
    }

    @ParameterizedTest(name = "reader cannot manage: {0}, visit={1}")
    @MethodSource("superAdminEndpoints")
    void platformReaderCannotWriteExportOrManagePackages(
            String name, Long visitTenantId, Endpoint endpoint) {
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:query")).thenReturn(true);
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService);
        if (tenantWritePermission(name) != null) {
            verify(permissionService).hasAnyPermissions(285L, tenantWritePermission(name));
        } else {
            verify(permissionService).hasAnyRoles(285L, "super_admin");
        }
        assertEquals(visitTenantId == null ? 1L : visitTenantId, TenantContextHolder.getTenantId());
    }

    @ParameterizedTest(name = "platform editor, visit={0}")
    @MethodSource("visitTenants")
    void platformEditorCanUpdateWithRealPermissionWithoutSuperAdminRole(Long visitTenantId) {
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:update")).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return true;
        });
        TenantSaveReqVO request = new TenantSaveReqVO();
        request.setId(122L);
        assertTrue(tenants.updateTenant(request).getData());
        verify(tenantService).updateTenant(same(request));
        verify(permissionService, never()).hasAnyRoles(anyLong(), any());
        verifyNoInteractions(packageService, security);
        assertEquals(visitTenantId == null ? 1L : visitTenantId, TenantContextHolder.getTenantId());
    }

    @ParameterizedTest(name = "editor cannot expand other operations: {0}, visit={1}")
    @MethodSource("superAdminEndpoints")
    void tenantEditPermissionDoesNotGrantOtherManagementOperations(
            String name, Long visitTenantId, Endpoint endpoint) {
        if (name.equals("tenant update")) return;
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:update")).thenReturn(true);
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService);
    }

    @ParameterizedTest(name = "platform operator: {0}, visit={1}")
    @MethodSource("tenantWriteEndpoints")
    void platformOperatorCanUseOnlyTheGrantedTenantAction(
            String name, Long visitTenantId, Endpoint endpoint) {
        login(285L, 1L, UserTypeEnum.ADMIN, visitTenantId);
        String permission = tenantWritePermission(name);
        when(permissionService.hasAnyPermissions(285L, permission)).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return true;
        });
        when(tenantService.createTenant(any())).thenReturn(167L);
        when(tenantService.getTenantPage(any())).thenReturn(new PageResult<>(List.of(), 0L));
        assertDoesNotThrow(() -> endpoint.invoke(tenants, packages));
        verify(permissionService).hasAnyPermissions(285L, permission);
        verify(permissionService, never()).hasAnyRoles(anyLong(), any());
        verifyNoInteractions(packageService, security);
        assertEquals(visitTenantId == null ? 1L : visitTenantId, TenantContextHolder.getTenantId());
    }

    @ParameterizedTest(name = "member cannot use tenant action: {0}, visit={1}")
    @MethodSource("tenantWriteEndpoints")
    void memberIdentityCannotUsePlatformTenantActions(
            String name, Long visitTenantId, Endpoint endpoint) {
        login(1L, 1L, UserTypeEnum.MEMBER, visitTenantId);
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService, permissionService, security);
    }

    @ParameterizedTest(name = "anonymous cannot use tenant action: {0}, visit={1}")
    @MethodSource("tenantWriteEndpoints")
    void anonymousIdentityCannotUsePlatformTenantActions(
            String name, Long visitTenantId, Endpoint endpoint) {
        TenantContextHolder.setTenantId(visitTenantId);
        assertThrows(AccessDeniedException.class, () -> endpoint.invoke(tenants, packages));
        verifyNoInteractions(tenantService, packageService, permissionService, security);
    }

    private static String tenantWritePermission(String name) {
        return switch (name) {
            case "tenant create" -> "system:tenant:create";
            case "tenant update" -> "system:tenant:update";
            case "tenant delete", "tenant batch delete" -> "system:tenant:delete";
            case "tenant export" -> "system:tenant:export";
            default -> null;
        };
    }

    private static Stream<Arguments> tenantWriteEndpoints() {
        return endpoints().entrySet().stream().filter(entry -> tenantWritePermission(entry.getKey()) != null)
                .flatMap(entry -> Stream.<Long>of(null, 121L)
                        .map(visit -> Arguments.of(entry.getKey(), visit, entry.getValue())));
    }

    private static Stream<Long> visitTenants() {
        return Stream.of(null, 121L);
    }

    @Test
    void superAdminInAnotherTenantIsNotPlatformAdministrator() {
        login(1L, 165L, UserTypeEnum.ADMIN, null);
        assertThrows(AccessDeniedException.class, () -> tenants.getTenantPage(new TenantPageReqVO()));
        verifyNoInteractions(tenantService, permissionService);
    }

    @Test
    void memberTokenCannotManageTenants() {
        login(1L, 1L, UserTypeEnum.MEMBER, null);
        assertThrows(AccessDeniedException.class, () -> tenants.getTenantPage(new TenantPageReqVO()));
        verifyNoInteractions(tenantService, permissionService);
    }

    @Test
    void anonymousUserCannotReadTenantLists() {
        assertThrows(AccessDeniedException.class, tenants::getTenantSimpleList);
        assertThrows(AccessDeniedException.class, packages::getTenantPackageList);
        verifyNoInteractions(tenantService, packageService);
    }

    @Test
    void platformSuperAdminCanQueryWhileVisitingAnotherTenant() {
        login(1L, 1L, UserTypeEnum.ADMIN, 121L);
        when(permissionService.hasAnyRoles(1L, "super_admin")).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return true;
        });
        when(permissionService.hasAnyPermissions(1L, "system:tenant:query")).thenAnswer(call -> {
            assertEquals(1L, TenantContextHolder.getTenantId());
            return true;
        });
        when(tenantService.getTenantPage(any())).thenReturn(new PageResult<>(List.of(), 0L));
        when(packageService.getTenantPackagePage(any())).thenReturn(new PageResult<>(List.of(), 0L));
        when(tenantService.getTenantListByStatus(anyInt())).thenReturn(List.of());
        when(packageService.getTenantPackageListByStatus(anyInt())).thenReturn(List.of());
        assertEquals(0L, tenants.getTenantPage(new TenantPageReqVO()).getData().getTotal());
        assertEquals(0L, packages.getTenantPackagePage(new TenantPackagePageReqVO()).getData().getTotal());
        assertTrue(tenants.getTenantSimpleList().getData().isEmpty());
        assertTrue(packages.getTenantPackageList().getData().isEmpty());
        assertEquals(121L, TenantContextHolder.getTenantId());
    }

    @Test
    void packageNamesExposeOnlyIdAndNameToPlatformTenantReader() {
        login(285L, 1L, UserTypeEnum.ADMIN, null);
        when(permissionService.hasAnyPermissions(285L, "system:tenant:query")).thenReturn(true);
        TenantPackageDO packageDO = new TenantPackageDO();
        packageDO.setId(111L);
        packageDO.setName("普通套餐");
        packageDO.setStatus(CommonStatusEnum.ENABLE.getStatus());
        packageDO.setMenuIds(Set.of(1L, 130L));
        packageDO.setRemark("套餐配置不应出现在精简名称接口中");
        when(packageService.getTenantPackageListByStatus(CommonStatusEnum.ENABLE.getStatus()))
                .thenReturn(List.of(packageDO));
        var result = packages.getTenantPackageList().getData();
        assertEquals(1, result.size());
        Map<?, ?> fields = new ObjectMapper().convertValue(result.get(0), Map.class);
        assertEquals(Set.of("id", "name"), fields.keySet());
        assertEquals(111L, result.get(0).getId());
        assertEquals("普通套餐", result.get(0).getName());
        verify(permissionService, never()).hasAnyRoles(anyLong(), any());
    }

    @Test
    void publicLoginTenantLookupsRemainAvailable() {
        TenantDO tenant = TenantDO.builder().id(122L).name("测试租户")
                .status(CommonStatusEnum.ENABLE.getStatus()).build();
        when(tenantService.getTenantByName("测试租户")).thenReturn(tenant);
        when(tenantService.getTenantByWebsite("test.example.com")).thenReturn(tenant);
        assertEquals(122L, tenants.getTenantIdByName("测试租户").getData());
        assertEquals(122L, tenants.getTenantByWebsite("test.example.com").getData().getId());
        verifyNoInteractions(permissionService);
    }

    private static void login(Long userId, Long tenantId, UserTypeEnum type, Long visitTenantId) {
        LoginUser user = new LoginUser();
        user.setId(userId);
        user.setTenantId(tenantId);
        user.setUserType(type.getValue());
        user.setVisitTenantId(visitTenantId);
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken(user, null, List.of()));
        TenantContextHolder.setTenantId(visitTenantId == null ? tenantId : visitTenantId);
    }

    private static Map<String, Endpoint> endpoints() {
        return Map.ofEntries(
                Map.entry("tenant create", (t, p) -> t.createTenant(new TenantSaveReqVO())),
                Map.entry("tenant update", (t, p) -> t.updateTenant(new TenantSaveReqVO())),
                Map.entry("tenant delete", (t, p) -> t.deleteTenant(122L)),
                Map.entry("tenant batch delete", (t, p) -> t.deleteTenantList(List.of(122L))),
                Map.entry("tenant detail", (t, p) -> t.getTenant(122L)),
                Map.entry("tenant page", (t, p) -> t.getTenantPage(new TenantPageReqVO())),
                Map.entry("tenant export", (t, p) -> t.exportTenantExcel(new TenantPageReqVO(), new MockHttpServletResponse())),
                Map.entry("tenant names", (t, p) -> t.getTenantSimpleList()),
                Map.entry("package create", (t, p) -> p.createTenantPackage(new TenantPackageSaveReqVO())),
                Map.entry("package update", (t, p) -> p.updateTenantPackage(new TenantPackageSaveReqVO())),
                Map.entry("package delete", (t, p) -> p.deleteTenantPackage(111L)),
                Map.entry("package batch delete", (t, p) -> p.deleteTenantPackageList(List.of(111L))),
                Map.entry("package detail", (t, p) -> p.getTenantPackage(111L)),
                Map.entry("package page", (t, p) -> p.getTenantPackagePage(new TenantPackagePageReqVO())),
                Map.entry("package names", (t, p) -> p.getTenantPackageList())
        );
    }

    private static boolean isTenantQuery(String name) {
        return name.equals("tenant detail") || name.equals("tenant page") || name.equals("tenant names")
                || name.equals("package names");
    }

    private static Stream<Arguments> managementEndpoints() {
        return endpoints().entrySet().stream().flatMap(entry -> Stream.of(121L, 122L, 166L)
                .map(tenantId -> Arguments.of(entry.getKey(), tenantId, entry.getValue())));
    }

    private static Stream<Arguments> queryEndpoints() {
        return endpoints().entrySet().stream().filter(entry -> isTenantQuery(entry.getKey()))
                .flatMap(entry -> Stream.<Long>of(null, 121L)
                        .map(visit -> Arguments.of(entry.getKey(), visit, entry.getValue())));
    }

    private static Stream<Arguments> superAdminEndpoints() {
        return endpoints().entrySet().stream().filter(entry -> !isTenantQuery(entry.getKey()))
                .flatMap(entry -> Stream.<Long>of(null, 121L)
                        .map(visit -> Arguments.of(entry.getKey(), visit, entry.getValue())));
    }

    @FunctionalInterface
    private interface Endpoint {
        void invoke(TenantController tenants, TenantPackageController packages) throws Exception;
    }

    @Configuration(proxyBeanMethods = false)
    @EnableMethodSecurity(jsr250Enabled = true)
    @Import({TenantController.class, TenantPackageController.class, TenantManagementPermission.class})
    static class Config {
        @Bean
        TenantService tenantService() {
            return mock(TenantService.class);
        }

        @Bean
        TenantPackageService packageService() {
            return mock(TenantPackageService.class);
        }

        @Bean
        PermissionService permissionService() {
            return mock(PermissionService.class);
        }

        @Bean("ss")
        SecurityFrameworkService security() {
            return mock(SecurityFrameworkService.class);
        }
    }
}
