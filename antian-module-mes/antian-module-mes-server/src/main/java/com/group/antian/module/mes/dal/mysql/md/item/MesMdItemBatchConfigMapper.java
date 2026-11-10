package com.group.antian.module.mes.dal.mysql.md.item;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.mes.dal.dataobject.md.item.MesMdItemBatchConfigDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MesMdItemBatchConfigMapper extends BaseMapperX<MesMdItemBatchConfigDO> {

    default MesMdItemBatchConfigDO selectByItemId(Long itemId) {
        return selectOne(MesMdItemBatchConfigDO::getItemId, itemId);
    }

    default int deleteByItemId(Long itemId) {
        return delete(MesMdItemBatchConfigDO::getItemId, itemId);
    }

}
