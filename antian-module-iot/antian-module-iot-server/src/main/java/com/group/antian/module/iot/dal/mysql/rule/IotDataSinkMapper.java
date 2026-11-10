package com.group.antian.module.iot.dal.mysql.rule;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.iot.controller.admin.rule.vo.data.sink.IotDataSinkPageReqVO;
import com.group.antian.module.iot.dal.dataobject.rule.IotDataSinkDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * IoT 数据流转目的 Mapper
 *
 * @author HUIHUI
 */
@Mapper
public interface IotDataSinkMapper extends BaseMapperX<IotDataSinkDO> {

    default PageResult<IotDataSinkDO> selectPage(IotDataSinkPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<IotDataSinkDO>()
                .likeIfPresent(IotDataSinkDO::getName, reqVO.getName())
                .eqIfPresent(IotDataSinkDO::getStatus, reqVO.getStatus())
                .eqIfPresent(IotDataSinkDO::getType, reqVO.getType())
                .betweenIfPresent(IotDataSinkDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(IotDataSinkDO::getId));
    }

    default List<IotDataSinkDO> selectListByStatus(Integer status) {
        return selectList(IotDataSinkDO::getStatus, status);
    }

    default IotDataSinkDO selectByName(String name) {
        return selectOne(IotDataSinkDO::getName, name);
    }

}