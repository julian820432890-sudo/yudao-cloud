package com.group.antian.module.mes.dal.mysql.pro.workrecord;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.mes.dal.dataobject.pro.workrecord.MesProWorkRecordDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 当前绑定状态（快照） Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesProWorkRecordMapper extends BaseMapperX<MesProWorkRecordDO> {

    default MesProWorkRecordDO selectByUserId(Long userId) {
        return selectOne(new LambdaQueryWrapperX<MesProWorkRecordDO>()
                .eq(MesProWorkRecordDO::getUserId, userId));
    }

}
