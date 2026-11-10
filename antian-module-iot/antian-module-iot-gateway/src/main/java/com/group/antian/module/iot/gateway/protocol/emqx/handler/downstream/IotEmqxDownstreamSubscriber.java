package com.group.antian.module.iot.gateway.protocol.emqx.handler.downstream;

import com.group.antian.module.iot.core.messagebus.core.IotMessageBus;
import com.group.antian.module.iot.core.mq.message.IotDeviceMessage;
import com.group.antian.module.iot.core.script.dto.IotScriptSource;
import com.group.antian.module.iot.gateway.protocol.AbstractIotProtocolDownstreamSubscriber;
import com.group.antian.module.iot.gateway.protocol.emqx.IotEmqxProtocol;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

/**
 * IoT 网关 EMQX 订阅者：接收下行给设备的消息
 *
 * @author 安天源码
 */
@Slf4j
public class IotEmqxDownstreamSubscriber extends AbstractIotProtocolDownstreamSubscriber {

    private final IotEmqxDownstreamHandler downstreamHandler;

    public IotEmqxDownstreamSubscriber(IotEmqxProtocol protocol, IotMessageBus messageBus) {
        super(protocol, messageBus);
        this.downstreamHandler = new IotEmqxDownstreamHandler(protocol);
    }

    @Override
    protected void handleMessage(IotDeviceMessage message) {
        downstreamHandler.handle(message);
    }

    @Override
    public Future<Void> handleRawMessage(IotDeviceMessage message, byte[] bytes, IotScriptSource source) {
        return downstreamHandler.handleRawMessage(message, bytes);
    }

    @Override
    public boolean supportsRawDownstream() {
        return true;
    }

}
