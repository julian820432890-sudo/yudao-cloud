package com.group.antian.module.pms.framework.rpc.config;

import com.group.antian.module.infra.api.file.FileApi;
import com.group.antian.module.system.api.dept.DeptApi;
import com.group.antian.module.system.api.notify.NotifyMessageSendApi;
import com.group.antian.module.system.api.permission.PermissionApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "pmsRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {AdminUserApi.class, DeptApi.class, PermissionApi.class,
        NotifyMessageSendApi.class, FileApi.class})
public class RpcConfiguration {
}
