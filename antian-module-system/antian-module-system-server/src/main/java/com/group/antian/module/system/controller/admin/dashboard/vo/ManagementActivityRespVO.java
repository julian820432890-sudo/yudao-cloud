package com.group.antian.module.system.controller.admin.dashboard.vo;

import com.group.antian.framework.common.pojo.PageResult;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ManagementActivityRespVO {
    private long opened;
    private long disabled;
    private long permission;
    private PageResult<Item> page;

    @Data
    public static class Item {
        private Long id;
        private LocalDateTime createTime;
        private String subject;
        private String action;
        private String operator;
    }
}
