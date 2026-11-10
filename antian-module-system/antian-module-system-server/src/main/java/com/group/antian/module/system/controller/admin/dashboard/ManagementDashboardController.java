package com.group.antian.module.system.controller.admin.dashboard;

import com.group.antian.framework.common.pojo.CommonResult;
import com.group.antian.module.system.controller.admin.dashboard.vo.*;
import com.group.antian.module.system.service.dashboard.ManagementDashboardService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import static com.group.antian.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - 首页管理概览")
@RestController
@RequestMapping("/system/dashboard")
@Validated
public class ManagementDashboardController {
    @Resource
    private ManagementDashboardService dashboardService;

    @GetMapping("/overview")
    @Operation(summary = "当前租户及数据权限范围内的管理概览")
    @PreAuthorize("@ss.hasPermission('system:user:query') && @ss.hasPermission('system:dept:query') && @ss.hasPermission('system:role:query')")
    public CommonResult<ManagementOverviewRespVO> getOverview() {
        return success(dashboardService.getOverview());
    }

    @GetMapping("/activity")
    @Operation(summary = "当前可见账号开通和已记录的权限操作统计")
    @PreAuthorize("@ss.hasPermission('system:user:query') && @ss.hasPermission('system:role:query') && @ss.hasPermission('system:operate-log:query')")
    public CommonResult<ManagementActivityRespVO> getActivity(@Valid ManagementActivityReqVO reqVO) {
        return success(dashboardService.getActivity(reqVO));
    }
}
