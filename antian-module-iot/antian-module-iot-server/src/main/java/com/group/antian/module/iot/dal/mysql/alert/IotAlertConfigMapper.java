package com.group.antian.module.iot.dal.mysql.alert;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.framework.mybatis.core.util.MyBatisUtils;
import com.group.antian.module.iot.controller.admin.alert.vo.config.IotAlertConfigPageReqVO;
import com.group.antian.module.iot.dal.dataobject.alert.IotAlertConfigDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * IoT 告警配置 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface IotAlertConfigMapper extends BaseMapperX<IotAlertConfigDO> {

    default PageResult<IotAlertConfigDO> selectPage(IotAlertConfigPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<IotAlertConfigDO>()
                .likeIfPresent(IotAlertConfigDO::getName, reqVO.getName())
                .eqIfPresent(IotAlertConfigDO::getStatus, reqVO.getStatus())
                .betweenIfPresent(IotAlertConfigDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(IotAlertConfigDO::getId));
    }

    default List<IotAlertConfigDO> selectListByStatus(Integer status) {
        return selectList(IotAlertConfigDO::getStatus, status);
    }

    default List<IotAlertConfigDO> selectListBySceneRuleIdAndStatus(Long sceneRuleId, Integer status) {
        return selectList(new LambdaQueryWrapperX<IotAlertConfigDO>()
                .eq(IotAlertConfigDO::getStatus, status)
                .apply(MyBatisUtils.findInSet("scene_rule_ids"), sceneRuleId));
    }

}
