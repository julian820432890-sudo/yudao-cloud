package com.group.antian.module.iot.gateway.config;

import com.group.antian.module.iot.core.biz.IotDeviceCommonApi;
import com.group.antian.module.iot.gateway.protocol.IotProtocolManager;
import com.group.antian.module.iot.gateway.serialize.IotMessageSerializerManager;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * IoT 网关配置类
 *
 * @author 安天源码
 */
@Configuration
@EnableConfigurationProperties(IotGatewayProperties.class)
public class IotGatewayConfiguration {

    @Bean
    public IotMessageSerializerManager iotMessageSerializerManager() {
        return new IotMessageSerializerManager();
    }

    @Bean
    public IotProtocolManager iotProtocolManager(IotGatewayProperties gatewayProperties,
                                                 IotDeviceCommonApi deviceApi) {
        return new IotProtocolManager(gatewayProperties, deviceApi);
    }

}
