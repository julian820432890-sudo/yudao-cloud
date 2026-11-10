package com.group.antian.module.ai.framework.rpc.config;

import com.group.antian.module.infra.api.file.FileApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "aiRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {FileApi.class, AdminUserApi.class})
public class RpcConfiguration {
}
