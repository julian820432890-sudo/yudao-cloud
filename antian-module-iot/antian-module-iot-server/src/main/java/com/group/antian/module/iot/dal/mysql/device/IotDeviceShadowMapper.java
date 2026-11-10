package com.group.antian.module.iot.dal.mysql.device;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.module.iot.dal.dataobject.device.IotDeviceShadowDO;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * IoT 设备影子 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface IotDeviceShadowMapper extends BaseMapperX<IotDeviceShadowDO> {

    default IotDeviceShadowDO selectByDeviceId(Long deviceId) {
        return selectOne(IotDeviceShadowDO::getDeviceId, deviceId);
    }

    default int updateByDeviceId(IotDeviceShadowDO update, Long deviceId) {
        return update(update, new LambdaUpdateWrapper<IotDeviceShadowDO>()
                .eq(IotDeviceShadowDO::getDeviceId, deviceId));
    }

    default int updateByDeviceIdAndVersion(IotDeviceShadowDO update, Long deviceId, Long expectVersion) {
        return update(update, new LambdaUpdateWrapper<IotDeviceShadowDO>()
                .eq(IotDeviceShadowDO::getDeviceId, deviceId)
                .eq(IotDeviceShadowDO::getVersion, expectVersion));
    }

    default int deleteByDeviceId(Long deviceId) {
        return delete(IotDeviceShadowDO::getDeviceId, deviceId);
    }

}
