package com.group.antian.module.hrm.framework.rpc.config;

import com.group.antian.module.bpm.api.task.BpmProcessInstanceApi;
import com.group.antian.module.system.api.dept.DeptApi;
import com.group.antian.module.system.api.logger.OperateLogApi;
import com.group.antian.module.system.api.notify.NotifyMessageSendApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "hrmRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {AdminUserApi.class, DeptApi.class, OperateLogApi.class,
        NotifyMessageSendApi.class, BpmProcessInstanceApi.class})
public class RpcConfiguration {
}
