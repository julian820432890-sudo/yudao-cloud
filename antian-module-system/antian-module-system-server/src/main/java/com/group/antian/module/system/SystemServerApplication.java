package com.group.antian.module.system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * @author 安天源码
 */
@SpringBootApplication(scanBasePackages = {"com.group.antian.module.system", "com.group.antian.module.infra"})
public class SystemServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SystemServerApplication.class, args);
    }

}
