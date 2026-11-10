package com.group.antian.module.system.controller.admin.dashboard.vo;

import com.group.antian.framework.common.pojo.PageParam;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Data
@EqualsAndHashCode(callSuper = true)
public class ManagementActivityReqVO extends PageParam {
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate startDate = LocalDate.now().withDayOfMonth(1);
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate endDate = LocalDate.now();
    @Pattern(regexp = "all|system")
    private String system = "all";
    @Size(max = 100)
    private String keyword;
    @Pattern(regexp = "opened|disabled|permission")
    private String category = "opened";

    @AssertTrue(message = "日期范围须完整、开始日期不能晚于结束日期，且范围不能超过一年")
    public boolean isDateRangeValid() {
        return startDate != null && endDate != null && !startDate.isAfter(endDate)
                && ChronoUnit.DAYS.between(startDate, endDate) <= 366;
    }

    @AssertTrue(message = "每页条数须在 1 至 100 之间")
    public boolean isPageSizeValid() {
        return getPageSize() != null && getPageSize() >= 1 && getPageSize() <= 100;
    }
}
