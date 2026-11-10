package com.group.antian.module.bpm.api.event;

import com.group.antian.module.bpm.framework.flowable.core.util.BpmHttpRequestUtils;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.client.RestTemplate;

/**
 * 离职申请审批结果的 HTTP 转发监听器
 *
 * @author 安天源码
 */
public class OaResignApplyStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private RestTemplate loadBalancedRestTemplate;

    @Override
    public String getProcessDefinitionKey() {
        return "oa_resign_apply";
    }

    @Override
    public void onEvent(@RequestBody @Valid BpmProcessInstanceStatusEvent event) {
        BpmHttpRequestUtils.executeBpmHttpRequest(event,
                "http://oa-server/rpc-api/oa/resign-apply/update-audit-status",
                loadBalancedRestTemplate);
    }

}
