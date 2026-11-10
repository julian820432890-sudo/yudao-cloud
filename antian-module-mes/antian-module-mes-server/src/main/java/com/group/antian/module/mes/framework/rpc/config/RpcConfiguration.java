package com.group.antian.module.mes.framework.rpc.config;

import com.group.antian.module.system.api.dept.PostApi;
import com.group.antian.module.system.api.dict.DictDataApi;
import com.group.antian.module.system.api.permission.RoleApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "mesRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {AdminUserApi.class, PostApi.class, RoleApi.class, DictDataApi.class})
public class RpcConfiguration {
}
