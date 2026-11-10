package com.group.antian.module.bpm.api.event;

import com.group.antian.module.bpm.framework.flowable.core.util.BpmHttpRequestUtils;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

/**
 * 会议室预定审批结果的 HTTP 转发监听器
 *
 * @author 安天源码
 */
public class OaMeetingRoomBookingStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private RestTemplate loadBalancedRestTemplate;

    @Override
    public String getProcessDefinitionKey() {
        return "oa_meeting_room_booking";
    }

    @Override
    public void onEvent(@RequestBody @Valid BpmProcessInstanceStatusEvent event) {
        BpmHttpRequestUtils.executeBpmHttpRequest(event,
                "http://oa-server/rpc-api/oa/meeting-room-booking/update-audit-status",
                loadBalancedRestTemplate);
    }

}
