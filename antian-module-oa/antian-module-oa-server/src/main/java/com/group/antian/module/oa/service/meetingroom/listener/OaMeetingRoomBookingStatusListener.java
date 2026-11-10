package com.group.antian.module.oa.service.meetingroom.listener;

import com.group.antian.module.bpm.api.event.BpmProcessInstanceStatusEvent;
import com.group.antian.module.bpm.api.event.BpmProcessInstanceStatusEventListener;
import com.group.antian.module.oa.enums.BpmModelConstants;
import com.group.antian.module.oa.service.meetingroom.OaMeetingRoomBookingService;
import jakarta.annotation.Resource;
import com.group.antian.module.oa.enums.ApiConstants;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * 会议室预定审批结果监听器
 *
 * @author 安天源码
 */
@RestController
@Validated
public class OaMeetingRoomBookingStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private OaMeetingRoomBookingService meetingRoomBookingService;

    @Override
    public String getProcessDefinitionKey() {
        return BpmModelConstants.MEETING_ROOM_BOOKING;
    }

    @Override
    @PostMapping(ApiConstants.PREFIX + "/meeting-room-booking/update-audit-status") // 提供给 bpm-server RPC 调用
    protected void onEvent(@RequestBody BpmProcessInstanceStatusEvent event) {
        meetingRoomBookingService.updateMeetingRoomBookingStatus(Long.parseLong(event.getBusinessKey()), event.getStatus());
    }
}
