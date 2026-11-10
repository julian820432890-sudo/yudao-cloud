package com.group.antian.module.im.framework.web.config;

import com.group.antian.framework.swagger.config.AntianSwaggerAutoConfiguration;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * im 模块的 web 组件的 Configuration
 */
@Configuration(proxyBeanMethods = false)
public class ImWebConfiguration {

    /**
     * im 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi imGroupedOpenApi() {
        return AntianSwaggerAutoConfiguration.buildGroupedOpenApi("im");
    }

}
