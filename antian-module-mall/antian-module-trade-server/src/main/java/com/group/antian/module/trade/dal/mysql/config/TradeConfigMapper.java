package com.group.antian.module.trade.dal.mysql.config;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.trade.dal.dataobject.config.TradeConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 交易中心配置 Mapper
 *
 * @author owen
 */
@Mapper
public interface TradeConfigMapper extends BaseMapperX<TradeConfigDO> {

}
