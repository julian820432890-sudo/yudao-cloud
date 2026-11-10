package com.group.antian.module.oa.dal.mysql.task;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.task.OaTaskLogDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * OA 任务反馈日志 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaTaskLogMapper extends BaseMapperX<OaTaskLogDO> {

    default List<OaTaskLogDO> selectListByTaskId(Long taskId) {
        return selectList(new LambdaQueryWrapperX<OaTaskLogDO>()
                .eq(OaTaskLogDO::getTaskId, taskId)
                .orderByAsc(OaTaskLogDO::getCreateTime)
                .orderByAsc(OaTaskLogDO::getId));
    }

    default void deleteByTaskId(Long taskId) {
        delete(OaTaskLogDO::getTaskId, taskId);
    }

}
