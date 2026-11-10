package com.group.antian.module.fms.dal.mysql.report;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.fms.dal.dataobject.report.FmsReportTemplateDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 报表模板 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface FmsReportTemplateMapper extends BaseMapperX<FmsReportTemplateDO> {

    default List<FmsReportTemplateDO> selectListByType(Integer type) {
        return selectList(new LambdaQueryWrapperX<FmsReportTemplateDO>()
                .eq(FmsReportTemplateDO::getType, type)
                .orderByAsc(FmsReportTemplateDO::getSort)
                .orderByAsc(FmsReportTemplateDO::getId));
    }

}
