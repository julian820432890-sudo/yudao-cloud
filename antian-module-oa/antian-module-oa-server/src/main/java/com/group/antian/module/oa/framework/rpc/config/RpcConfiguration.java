package com.group.antian.module.oa.framework.rpc.config;

import com.group.antian.module.bpm.api.task.BpmProcessInstanceApi;
import com.group.antian.module.infra.api.file.FileApi;
import com.group.antian.module.system.api.dept.DeptApi;
import com.group.antian.module.system.api.dict.DictDataApi;
import com.group.antian.module.system.api.notify.NotifyMessageSendApi;
import com.group.antian.module.system.api.permission.PermissionApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "oaRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {BpmProcessInstanceApi.class, FileApi.class, DeptApi.class, DictDataApi.class,
        NotifyMessageSendApi.class, PermissionApi.class, AdminUserApi.class})
public class RpcConfiguration {
}
