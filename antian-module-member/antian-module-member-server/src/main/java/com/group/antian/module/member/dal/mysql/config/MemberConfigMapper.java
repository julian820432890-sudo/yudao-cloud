package com.group.antian.module.member.dal.mysql.config;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.member.dal.dataobject.config.MemberConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 积分设置 Mapper
 *
 * @author QingX
 */
@Mapper
public interface MemberConfigMapper extends BaseMapperX<MemberConfigDO> {
}
