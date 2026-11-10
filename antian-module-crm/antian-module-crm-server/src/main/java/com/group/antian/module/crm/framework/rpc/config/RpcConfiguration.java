package com.group.antian.module.crm.framework.rpc.config;

import com.group.antian.module.bpm.api.task.BpmProcessInstanceApi;
import com.group.antian.module.system.api.dept.DeptApi;
import com.group.antian.module.system.api.dept.PostApi;
import com.group.antian.module.system.api.logger.OperateLogApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "crmRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {AdminUserApi.class, DeptApi.class, PostApi.class,
        OperateLogApi.class,
        BpmProcessInstanceApi.class})
public class RpcConfiguration {
}
