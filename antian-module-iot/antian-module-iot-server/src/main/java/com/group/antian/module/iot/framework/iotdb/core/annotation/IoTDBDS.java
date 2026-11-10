package com.group.antian.module.iot.framework.iotdb.core.annotation;

import com.baomidou.dynamic.datasource.annotation.DS;

import java.lang.annotation.*;

/**
 * IoTDB 数据源
 *
 * 对应 spring.datasource.dynamic.datasource.iotdb 条目
 *
 * @author 安天源码
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@DS("iotdb")
public @interface IoTDBDS {
}
