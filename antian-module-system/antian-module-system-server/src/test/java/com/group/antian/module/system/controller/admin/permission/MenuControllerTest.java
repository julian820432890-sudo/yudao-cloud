package com.group.antian.module.system.controller.admin.permission;

import com.group.antian.framework.common.pojo.CommonResult;
import com.group.antian.framework.test.core.ut.BaseMockitoUnitTest;
import com.group.antian.module.system.controller.admin.permission.vo.menu.MenuListReqVO;
import com.group.antian.module.system.controller.admin.permission.vo.menu.MenuRespVO;
import com.group.antian.module.system.dal.dataobject.permission.MenuDO;
import com.group.antian.module.system.service.permission.MenuService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static com.group.antian.framework.common.util.collection.CollectionUtils.convertList;
import static com.group.antian.framework.test.core.util.RandomUtils.randomPojo;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

/**
 * {@link MenuController} 的单元测试
 *
 * @author 安天源码
 */
public class MenuControllerTest extends BaseMockitoUnitTest {

    @InjectMocks
    private MenuController menuController;

    @Mock
    private MenuService menuService;

    @Test
    public void testGetMenuList_filterByTenant() {
        // 准备参数
        MenuListReqVO reqVO = new MenuListReqVO();
        // mock 方法：租户过滤后的菜单
        MenuDO menu1 = randomPojo(MenuDO.class, o -> o.setId(1L).setSort(2));
        MenuDO menu2 = randomPojo(MenuDO.class, o -> o.setId(2L).setSort(1));
        when(menuService.getMenuListByTenant(same(reqVO))).thenReturn(new ArrayList<>(Arrays.asList(menu1, menu2)));

        // 调用
        CommonResult<List<MenuRespVO>> result = menuController.getMenuList(reqVO);
        // 断言：按照 sort 排序，且只使用租户过滤后的菜单
        assertEquals(Arrays.asList(2L, 1L), convertList(result.getData(), MenuRespVO::getId));
        verify(menuService).getMenuListByTenant(same(reqVO));
        verify(menuService, never()).getMenuList(any(MenuListReqVO.class));
    }

}
