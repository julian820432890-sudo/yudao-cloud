package com.group.antian.module.iot.framework.rpc.config;

import com.group.antian.module.system.api.mail.MailSendApi;
import com.group.antian.module.system.api.notify.NotifyMessageSendApi;
import com.group.antian.module.system.api.sms.SmsSendApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "iotRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {
        AdminUserApi.class, SmsSendApi.class, MailSendApi.class, NotifyMessageSendApi.class
})
public class RpcConfiguration {
}
