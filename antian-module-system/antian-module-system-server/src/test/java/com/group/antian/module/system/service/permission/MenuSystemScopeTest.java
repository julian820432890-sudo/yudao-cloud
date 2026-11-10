package com.group.antian.module.system.service.permission;

import com.group.antian.framework.test.core.ut.BaseMockitoUnitTest;
import com.group.antian.module.system.controller.admin.permission.vo.menu.MenuListReqVO;
import com.group.antian.module.system.dal.dataobject.permission.MenuDO;
import com.group.antian.module.system.dal.mysql.permission.MenuMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

class MenuSystemScopeTest extends BaseMockitoUnitTest {
    @InjectMocks private MenuServiceImpl service;
    @Mock private MenuMapper mapper;

    private final MenuDO system = menu(1L, 0L, "system");
    private final MenuDO tenant = menu(10L, 1L, "tenant");
    private final MenuDO query = menu(11L, 10L, "");
    private final MenuDO business = menu(20L, 0L, "erp");
    private final MenuDO product = menu(21L, 20L, "product");

    @BeforeEach void enableScope() {
        ReflectionTestUtils.setField(service, "systemOnly", true);
    }

    @Test void filtersNestedBusinessMenusForFullAdministrator() {
        // Deliberately unordered: children precede parents in stored data.
        when(mapper.selectList()).thenReturn(List.of(query, product, tenant, business, system));
        assertEquals(List.of(query, tenant, system), service.getMenuList());
    }

    @Test void filtersRoleMenuIdsWithoutDroppingSystemButtons() {
        when(mapper.selectList()).thenReturn(List.of(system, tenant, query, business, product));
        when(mapper.selectByIds(List.of(11L, 21L))).thenReturn(List.of(query, product));
        assertEquals(List.of(query), service.getMenuList(List.of(11L, 21L)));
    }

    @Test void filtersSearchResultsEvenWhenRootIsNotInResults() {
        MenuListReqVO request = new MenuListReqVO();
        when(mapper.selectList(request)).thenReturn(List.of(tenant, product));
        when(mapper.selectList()).thenReturn(List.of(system, tenant, query, business, product));
        assertEquals(List.of(tenant), service.getMenuList(request));
    }

    private static MenuDO menu(Long id, Long parent, String path) {
        return new MenuDO().setId(id).setParentId(parent).setPath(path);
    }
}
