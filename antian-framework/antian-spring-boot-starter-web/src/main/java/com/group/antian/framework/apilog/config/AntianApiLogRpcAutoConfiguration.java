package com.group.antian.framework.apilog.config;

import com.group.antian.framework.common.biz.infra.logger.ApiAccessLogCommonApi;
import com.group.antian.framework.common.biz.infra.logger.ApiErrorLogCommonApi;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

/** 本地实现优先，避免系统服务把日志 RPC 调用发回自身。 */
@AutoConfiguration
public class AntianApiLogRpcAutoConfiguration {
    @Configuration(proxyBeanMethods = false)
    @ConditionalOnMissingBean(ApiAccessLogCommonApi.class)
    @EnableFeignClients(clients = ApiAccessLogCommonApi.class)
    static class AccessLogRpcConfiguration {
    }

    @Configuration(proxyBeanMethods = false)
    @ConditionalOnMissingBean(ApiErrorLogCommonApi.class)
    @EnableFeignClients(clients = ApiErrorLogCommonApi.class)
    static class ErrorLogRpcConfiguration {
    }
}
