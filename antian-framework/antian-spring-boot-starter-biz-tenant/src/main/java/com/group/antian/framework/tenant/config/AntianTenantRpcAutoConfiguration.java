package com.group.antian.framework.tenant.config;

import com.group.antian.framework.tenant.core.rpc.TenantRequestInterceptor;
import com.group.antian.framework.common.biz.system.tenant.TenantCommonApi;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;

@AutoConfiguration
@ConditionalOnProperty(prefix = "antian.tenant", value = "enable", matchIfMissing = true) // 允许使用 antian.tenant.enable=false 禁用多租户
@EnableFeignClients(clients = TenantCommonApi.class) // 主要是引入相关的 API 服务
public class AntianTenantRpcAutoConfiguration {

    @Bean
    public TenantRequestInterceptor tenantRequestInterceptor() {
        return new TenantRequestInterceptor();
    }

}
