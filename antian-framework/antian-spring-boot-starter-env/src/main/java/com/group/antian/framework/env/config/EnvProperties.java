package com.group.antian.framework.env.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * 环境配置
 *
 * @author 安天源码
 */
@ConfigurationProperties(prefix = "antian.env")
@Data
public class EnvProperties {

    public static final String TAG_KEY = "antian.env.tag";

    /**
     * 环境标签
     */
    private String tag;

}
