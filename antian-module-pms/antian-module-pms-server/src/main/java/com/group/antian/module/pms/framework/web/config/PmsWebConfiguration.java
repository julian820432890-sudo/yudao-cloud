package com.group.antian.module.pms.framework.web.config;

import com.group.antian.framework.swagger.config.AntianSwaggerAutoConfiguration;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * PMS 模块的 Web 配置
 *
 * @author 安天源码
 */
@Configuration(proxyBeanMethods = false)
public class PmsWebConfiguration {

    /**
     * 创建 PMS 模块的 OpenAPI 分组
     *
     * @return PMS OpenAPI 分组
     */
    @Bean
    public GroupedOpenApi pmsGroupedOpenApi() {
        return AntianSwaggerAutoConfiguration.buildGroupedOpenApi("pms");
    }

}
