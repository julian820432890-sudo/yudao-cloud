package com.group.antian.module.fms.dal.mysql.report.balance;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.fms.dal.dataobject.report.balance.FmsBalanceSheetConfigDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 资产负债表配置 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface FmsBalanceSheetConfigMapper extends BaseMapperX<FmsBalanceSheetConfigDO> {

    default List<FmsBalanceSheetConfigDO> selectListByAccountSetId(Long accountSetId) {
        return selectList(new LambdaQueryWrapperX<FmsBalanceSheetConfigDO>()
                .eq(FmsBalanceSheetConfigDO::getAccountSetId, accountSetId)
                .orderByAsc(FmsBalanceSheetConfigDO::getSort)
                .orderByAsc(FmsBalanceSheetConfigDO::getId));
    }

}
