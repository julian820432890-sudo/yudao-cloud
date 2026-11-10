package com.group.antian.module.system.controller.admin.dashboard.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/** 首页只返回统计与展示需要的字段，不返回用户密码、手机等信息。 */
@Data
public class ManagementOverviewRespVO {
    private long companyCount;
    private long userCount;
    private long deptCount;
    private long roleCount;
    private long unassignedCount;
    private List<Organization> organizations = new ArrayList<>();
    private List<Member> members = new ArrayList<>();

    @Data
    public static class Organization {
        private Long id;
        private String name;
        private int memberCount;
        private int directMemberCount;
        private int deptCount;
        private List<Organization> children = new ArrayList<>();
    }

    @Data
    public static class Member {
        private Long id;
        private String username;
        private String nickname;
        private Long deptId;
        private String deptName;
        private LocalDateTime createTime;
        private List<String> roles = new ArrayList<>();
    }
}
