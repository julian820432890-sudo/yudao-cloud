package com.group.antian.module.mes.dal.mysql.wm.transfer;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.mes.dal.dataobject.wm.transfer.MesWmTransferDetailDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * MES 调拨明细 Mapper
 */
@Mapper
public interface MesWmTransferDetailMapper extends BaseMapperX<MesWmTransferDetailDO> {

    default List<MesWmTransferDetailDO> selectListByLineId(Long lineId) {
        return selectList(new LambdaQueryWrapperX<MesWmTransferDetailDO>()
                .eq(MesWmTransferDetailDO::getLineId, lineId)
                .orderByAsc(MesWmTransferDetailDO::getId));
    }

    default List<MesWmTransferDetailDO> selectListByTransferId(Long transferId) {
        return selectList(new LambdaQueryWrapperX<MesWmTransferDetailDO>()
                .eq(MesWmTransferDetailDO::getTransferId, transferId)
                .orderByAsc(MesWmTransferDetailDO::getId));
    }

    default void deleteByLineId(Long lineId) {
        delete(MesWmTransferDetailDO::getLineId, lineId);
    }

    default void deleteByTransferId(Long transferId) {
        delete(MesWmTransferDetailDO::getTransferId, transferId);
    }

}
