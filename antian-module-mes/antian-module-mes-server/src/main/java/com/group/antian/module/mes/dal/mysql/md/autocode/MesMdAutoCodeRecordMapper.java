package com.group.antian.module.mes.dal.mysql.md.autocode;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.mes.dal.dataobject.md.autocode.MesMdAutoCodeRecordDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 编码生成记录 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesMdAutoCodeRecordMapper extends BaseMapperX<MesMdAutoCodeRecordDO> {

    default MesMdAutoCodeRecordDO selectByResult(String result) {
        return selectOne(MesMdAutoCodeRecordDO::getResult, result);
    }

}
