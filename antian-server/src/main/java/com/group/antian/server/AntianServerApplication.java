package com.group.antian.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * @author 安天源码
 */
@SuppressWarnings("SpringComponentScan") // 忽略 IDEA 无法识别 ${antian.info.base-package}
@SpringBootApplication(scanBasePackages = {"${antian.info.base-package}.server", "${antian.info.base-package}.module"},
        excludeName = {
            // RPC 相关
//            "org.springframework.cloud.openfeign.FeignAutoConfiguration",
//            "com.group.antian.module.system.framework.rpc.config.RpcConfiguration"
        })
public class AntianServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(AntianServerApplication.class, args);
//        new SpringApplicationBuilder(AntianServerApplication.class)
//                .applicationStartup(new BufferingApplicationStartup(20480))
//                .run(args);

    }

}
