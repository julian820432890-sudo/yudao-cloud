package com.group.antian.module.infra.dal.mysql.db;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.infra.dal.dataobject.db.DataSourceConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 数据源配置 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface DataSourceConfigMapper extends BaseMapperX<DataSourceConfigDO> {
}
