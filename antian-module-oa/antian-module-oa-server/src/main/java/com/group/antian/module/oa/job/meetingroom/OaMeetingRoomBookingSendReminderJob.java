package com.group.antian.module.oa.job.meetingroom;

import cn.hutool.core.util.StrUtil;
import com.xxl.job.core.handler.annotation.XxlJob;
import com.group.antian.framework.tenant.core.job.TenantJob;
import com.group.antian.module.oa.service.meetingroom.OaMeetingRoomBookingService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 * OA 会议开始提醒 Job
 *
 * 发送已通过且待使用会议的开始提醒
 *
 * @author 安天源码
 */
@Component
public class OaMeetingRoomBookingSendReminderJob {

    @Resource
    private OaMeetingRoomBookingService meetingRoomBookingService;

    @XxlJob("oaMeetingRoomBookingSendReminderJob")
    @TenantJob
    public String execute() {
        int count = meetingRoomBookingService.sendMeetingRoomBookingReminders();
        return StrUtil.format("发送会议提醒 {} 条", count);
    }

}
