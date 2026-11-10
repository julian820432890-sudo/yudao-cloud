package com.group.antian.module.system.framework.support;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/** 系统服务内嵌的文件、参数及日志公共支持。 */
@Configuration(proxyBeanMethods = false)
@MapperScan(basePackages = "com.group.antian.module.infra.dal.mysql", annotationClass = Mapper.class)
public class SystemSupportConfiguration {
}
