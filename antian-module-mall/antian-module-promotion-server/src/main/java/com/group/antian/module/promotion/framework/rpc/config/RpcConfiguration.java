package com.group.antian.module.promotion.framework.rpc.config;

import com.group.antian.module.infra.api.websocket.WebSocketSenderApi;
import com.group.antian.module.member.api.user.MemberUserApi;
import com.group.antian.module.product.api.category.ProductCategoryApi;
import com.group.antian.module.product.api.sku.ProductSkuApi;
import com.group.antian.module.product.api.spu.ProductSpuApi;
import com.group.antian.module.system.api.social.SocialClientApi;
import com.group.antian.module.system.api.user.AdminUserApi;
import com.group.antian.module.trade.api.order.TradeOrderApi;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

@Configuration(value = "promotionRpcConfiguration", proxyBeanMethods = false)
@EnableFeignClients(clients = {ProductSkuApi.class, ProductSpuApi.class, ProductCategoryApi.class,
        MemberUserApi.class, TradeOrderApi.class, AdminUserApi.class, SocialClientApi.class,
        WebSocketSenderApi.class})
public class RpcConfiguration {
}
