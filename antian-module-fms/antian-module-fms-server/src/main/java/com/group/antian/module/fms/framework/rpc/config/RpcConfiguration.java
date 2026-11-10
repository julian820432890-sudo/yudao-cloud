package com.group.antian.module.fms.framework.rpc.config;

import com.group.antian.module.infra.api.file.FileApi;
import com.group.antian.module.system.api.dept.DeptApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "fmsRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {AdminUserApi.class, DeptApi.class, FileApi.class})
public class RpcConfiguration {
}
