package com.group.antian.module.member.framework.rpc.config;

import com.group.antian.module.system.api.logger.LoginLogApi;
import com.group.antian.module.system.api.sms.SmsCodeApi;
import com.group.antian.module.system.api.social.SocialClientApi;
import com.group.antian.module.system.api.social.SocialUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "memberRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {SmsCodeApi.class, LoginLogApi.class, SocialUserApi.class, SocialClientApi.class})
public class RpcConfiguration {
}
