package com.group.antian.module.fms.dal.mysql.report.cashflow;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.fms.dal.dataobject.report.cashflow.FmsCashFlowExtendConfigDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 现金流量表扩展配置 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface FmsCashFlowExtendConfigMapper extends BaseMapperX<FmsCashFlowExtendConfigDO> {

    default List<FmsCashFlowExtendConfigDO> selectListByAccountSetIdAndCategory(Long accountSetId, Integer category) {
        return selectList(new LambdaQueryWrapperX<FmsCashFlowExtendConfigDO>()
                .eq(FmsCashFlowExtendConfigDO::getAccountSetId, accountSetId)
                .eqIfPresent(FmsCashFlowExtendConfigDO::getCategory, category)
                .orderByAsc(FmsCashFlowExtendConfigDO::getSort)
                .orderByAsc(FmsCashFlowExtendConfigDO::getId));
    }

}
