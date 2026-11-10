package com.group.antian.module.wms.dal.mysql.order.shipment;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.wms.dal.dataobject.order.shipment.WmsShipmentOrderDetailDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;

/**
 * WMS 出库单明细 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface WmsShipmentOrderDetailMapper extends BaseMapperX<WmsShipmentOrderDetailDO> {

    default List<WmsShipmentOrderDetailDO> selectListByOrderId(Long orderId) {
        return selectList(WmsShipmentOrderDetailDO::getOrderId, orderId);
    }

    default List<WmsShipmentOrderDetailDO> selectListByOrderIds(Collection<Long> orderIds) {
        return selectList(new LambdaQueryWrapperX<WmsShipmentOrderDetailDO>()
                .inIfPresent(WmsShipmentOrderDetailDO::getOrderId, orderIds)
                .orderByAsc(WmsShipmentOrderDetailDO::getOrderId)
                .orderByAsc(WmsShipmentOrderDetailDO::getId));
    }

    default void deleteByOrderId(Long orderId) {
        delete(WmsShipmentOrderDetailDO::getOrderId, orderId);
    }

    default Long selectCountBySkuId(Long skuId) {
        return selectCount(WmsShipmentOrderDetailDO::getSkuId, skuId);
    }

}
