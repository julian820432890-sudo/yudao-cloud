package com.group.antian.module.iot.gateway.protocol.tcp.handler.downstream;

import com.group.antian.module.iot.core.messagebus.core.IotMessageBus;
import com.group.antian.module.iot.core.mq.message.IotDeviceMessage;
import com.group.antian.module.iot.core.script.dto.IotScriptSource;
import com.group.antian.module.iot.gateway.protocol.AbstractIotProtocolDownstreamSubscriber;
import com.group.antian.module.iot.gateway.protocol.IotProtocol;
import io.vertx.core.Future;
import lombok.extern.slf4j.Slf4j;

/**
 * IoT 网关 TCP 下游订阅者：接收下行给设备的消息
 *
 * @author 安天源码
 */
@Slf4j
public class IotTcpDownstreamSubscriber extends AbstractIotProtocolDownstreamSubscriber {

    private final IotTcpDownstreamHandler downstreamHandler;

    public IotTcpDownstreamSubscriber(IotProtocol protocol,
                                      IotTcpDownstreamHandler downstreamHandler,
                                      IotMessageBus messageBus) {
        super(protocol, messageBus);
        this.downstreamHandler = downstreamHandler;
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
