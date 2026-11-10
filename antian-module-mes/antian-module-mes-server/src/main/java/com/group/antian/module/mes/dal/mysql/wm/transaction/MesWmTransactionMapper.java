package com.group.antian.module.mes.dal.mysql.wm.transaction;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.mes.dal.dataobject.wm.transaction.MesWmTransactionDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 库存事务流水 Mapper
 */
@Mapper
public interface MesWmTransactionMapper extends BaseMapperX<MesWmTransactionDO> {

}
