package com.group.antian.module.iot.controller.admin.device;

import cn.hutool.core.collection.CollUtil;
import com.group.antian.framework.common.pojo.CommonResult;
import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.common.util.object.BeanUtils;
import com.group.antian.framework.security.core.service.SecurityFrameworkService;
import com.group.antian.module.iot.controller.admin.device.vo.message.IotDeviceMessagePageReqVO;
import com.group.antian.module.iot.controller.admin.device.vo.message.IotDeviceMessageRespPairVO;
import com.group.antian.module.iot.controller.admin.device.vo.message.IotDeviceMessageRespVO;
import com.group.antian.module.iot.controller.admin.device.vo.message.IotDeviceMessageSendReqVO;
import com.group.antian.module.iot.core.enums.IotDeviceMessageMethodEnum;
import com.group.antian.module.iot.core.mq.message.IotDeviceMessage;
import com.group.antian.module.iot.dal.dataobject.device.IotDeviceMessageDO;
import com.group.antian.module.iot.service.device.IotDeviceService;
import com.group.antian.module.iot.service.device.message.IotDeviceMessageService;
import com.group.antian.module.iot.service.thingmodel.IotThingModelService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.group.antian.framework.common.exception.enums.GlobalErrorCodeConstants.FORBIDDEN;
import static com.group.antian.framework.common.exception.util.ServiceExceptionUtil.exception;
import static com.group.antian.framework.common.pojo.CommonResult.success;
import static com.group.antian.framework.common.util.collection.CollectionUtils.convertList;
import static com.group.antian.framework.common.util.collection.CollectionUtils.convertMap;
import static com.group.antian.module.iot.enums.IotPermissionConstants.DEVICE_MESSAGE_RAW_SEND;

@Tag(name = "管理后台 - IoT 设备消息")
@RestController
@RequestMapping("/iot/device/message")
@Validated
public class IotDeviceMessageController {

    @Resource
    private IotDeviceMessageService deviceMessageService;
    @Resource
    private IotDeviceService deviceService;
    @Resource
    private IotThingModelService thingModelService;
    @Resource
    private SecurityFrameworkService securityFrameworkService;

    @GetMapping("/page")
    @Operation(summary = "获得设备消息分页")
    @PreAuthorize("@ss.hasPermission('iot:device:message-query')")
    public CommonResult<PageResult<IotDeviceMessageRespVO>> getDeviceMessagePage(
            @Valid IotDeviceMessagePageReqVO pageReqVO) {
        PageResult<IotDeviceMessageDO> pageResult = deviceMessageService.getDeviceMessagePage(pageReqVO);
        return success(BeanUtils.toBean(pageResult, IotDeviceMessageRespVO.class));
    }

    @GetMapping("/pair-page")
    @Operation(summary = "获得设备消息对分页")
    @PreAuthorize("@ss.hasPermission('iot:device:message-query')")
    public CommonResult<PageResult<IotDeviceMessageRespPairVO>> getDeviceMessagePairPage(
            @Valid IotDeviceMessagePageReqVO pageReqVO) {
        // 1.1 先按照条件，查询 request 的消息（非 reply）
        pageReqVO.setReply(false);
        PageResult<IotDeviceMessageDO> requestMessagePageResult = deviceMessageService.getDeviceMessagePage(pageReqVO);
        if (CollUtil.isEmpty(requestMessagePageResult.getList())) {
            return success(PageResult.empty());
        }
        // 1.2 接着按照 requestIds，批量查询 reply 消息
        List<String> requestIds = convertList(requestMessagePageResult.getList(), IotDeviceMessageDO::getRequestId);
        List<IotDeviceMessageDO> replyMessageList = deviceMessageService.getDeviceMessageListByRequestIdsAndReply(
                pageReqVO.getDeviceId(), requestIds, true);
        Map<String, IotDeviceMessageDO> replyMessages = convertMap(replyMessageList, IotDeviceMessageDO::getRequestId);

        // 2. 组装结果
        List<IotDeviceMessageRespPairVO> pairMessages = convertList(requestMessagePageResult.getList(),
                requestMessage -> {
            IotDeviceMessageDO replyMessage = replyMessages.get(requestMessage.getRequestId());
            return new IotDeviceMessageRespPairVO()
                    .setRequest(BeanUtils.toBean(requestMessage, IotDeviceMessageRespVO.class))
                    .setReply(BeanUtils.toBean(replyMessage, IotDeviceMessageRespVO.class));
        });
        return success(new PageResult<>(pairMessages, requestMessagePageResult.getTotal()));
    }

    @PostMapping("/send")
    @Operation(summary = "发送消息", description = "可用于设备模拟")
    @PreAuthorize("@ss.hasPermission('iot:device:message-send')")
    public CommonResult<Boolean> sendDeviceMessage(@Valid @RequestBody IotDeviceMessageSendReqVO sendReqVO) {
        // 1. 校验透传下发的权限：透传下发是新增的危险能力（可以直接驱动 Modbus 写），需要独立的按钮权限；raw.post 不提供模拟（会改写在线状态和路由）
        if (IotDeviceMessageMethodEnum.RAW_PUSH.getMethod().equals(sendReqVO.getMethod())
                && !securityFrameworkService.hasPermission(DEVICE_MESSAGE_RAW_SEND)) {
            throw exception(FORBIDDEN);
        }
        // 2. 发送消息
        deviceMessageService.sendDeviceMessage(BeanUtils.toBean(sendReqVO, IotDeviceMessage.class));
        return success(true);
    }

}
