package com.group.antian.module.infra.framework.file.config;

import com.group.antian.module.infra.framework.file.core.client.FileClientFactory;
import com.group.antian.module.infra.framework.file.core.client.FileClientFactoryImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 文件配置类
 *
 * @author 安天源码
 */
@Configuration(proxyBeanMethods = false)
public class AntianFileAutoConfiguration {

    @Bean
    public FileClientFactory fileClientFactory() {
        return new FileClientFactoryImpl();
    }

}
