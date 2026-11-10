package com.group.antian.module.fms.dal.mysql.report.cashflow;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.fms.dal.dataobject.report.cashflow.FmsCashFlowStatementConfigDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 现金流量表配置 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface FmsCashFlowStatementConfigMapper extends BaseMapperX<FmsCashFlowStatementConfigDO> {

    default List<FmsCashFlowStatementConfigDO> selectListByAccountSetId(Long accountSetId) {
        return selectList(new LambdaQueryWrapperX<FmsCashFlowStatementConfigDO>()
                .eq(FmsCashFlowStatementConfigDO::getAccountSetId, accountSetId)
                .orderByAsc(FmsCashFlowStatementConfigDO::getSort)
                .orderByAsc(FmsCashFlowStatementConfigDO::getId));
    }

}
