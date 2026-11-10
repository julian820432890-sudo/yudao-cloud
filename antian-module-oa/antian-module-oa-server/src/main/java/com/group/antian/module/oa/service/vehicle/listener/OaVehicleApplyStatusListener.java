package com.group.antian.module.oa.service.vehicle.listener;

import com.group.antian.module.oa.service.vehicle.OaVehicleApplyService;
import com.group.antian.module.oa.enums.BpmModelConstants;

import com.group.antian.module.bpm.api.event.BpmProcessInstanceStatusEvent;
import jakarta.annotation.Resource;
import com.group.antian.module.oa.enums.ApiConstants;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.group.antian.module.bpm.api.event.BpmProcessInstanceStatusEventListener;

/**
 * 用车申请审批结果监听器
 *
 * @author 安天源码
 */
@RestController
@Validated
public class OaVehicleApplyStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private OaVehicleApplyService vehicleApplyService;

    @Override
    public String getProcessDefinitionKey() {
        return BpmModelConstants.VEHICLE_APPLY;
    }

    @Override
    @PostMapping(ApiConstants.PREFIX + "/vehicle-apply/update-audit-status") // 提供给 bpm-server RPC 调用
    protected void onEvent(@RequestBody BpmProcessInstanceStatusEvent event) {
        vehicleApplyService.updateVehicleApplyStatus(Long.parseLong(event.getBusinessKey()), event.getStatus());
    }

}
