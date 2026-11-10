package com.group.antian.module.oa.dal.mysql.workreport;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.common.util.date.LocalDateTimeUtils;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.controller.admin.workreport.vo.OaWorkReportPageReqVO;
import com.group.antian.module.oa.dal.dataobject.workreport.OaWorkReportDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;
import java.time.LocalDateTime;

/**
 * OA 工作汇报 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaWorkReportMapper extends BaseMapperX<OaWorkReportDO> {

    default OaWorkReportDO selectByNo(String no) {
        return selectOne(OaWorkReportDO::getNo, no);
    }

    default PageResult<OaWorkReportDO> selectPage(OaWorkReportPageReqVO pageReqVO, Long userId) {
        return selectPage(pageReqVO, new LambdaQueryWrapperX<OaWorkReportDO>()
                .eq(OaWorkReportDO::getCreator, userId.toString())
                .likeIfPresent(OaWorkReportDO::getNo, pageReqVO.getNo())
                .eqIfPresent(OaWorkReportDO::getDeptId, pageReqVO.getDeptId())
                .betweenIfPresent(OaWorkReportDO::getStartTime, pageReqVO.getPeriodTime())
                .betweenIfPresent(OaWorkReportDO::getStartTime,
                        LocalDateTimeUtils.getDayBeginTime(pageReqVO.getStartTime()),
                        LocalDateTimeUtils.getDayEndTime(pageReqVO.getStartTime()))
                .betweenIfPresent(OaWorkReportDO::getEndTime,
                        LocalDateTimeUtils.getDayBeginTime(pageReqVO.getEndTime()),
                        LocalDateTimeUtils.getDayEndTime(pageReqVO.getEndTime()))
                .eqIfPresent(OaWorkReportDO::getType, pageReqVO.getType())
                .eqIfPresent(OaWorkReportDO::getStatus, pageReqVO.getStatus())
                .betweenIfPresent(OaWorkReportDO::getCreateTime, pageReqVO.getCreateTime())
                .orderByDesc(OaWorkReportDO::getStartTime)
                .orderByDesc(OaWorkReportDO::getId));
    }

    default List<OaWorkReportDO> selectListByCreatorsAndTypeAndStatusAndStartTimeBetween(
            Collection<String> creators, Integer type, Integer status,
            LocalDateTime startTime, LocalDateTime endTime) {
        return selectList(new LambdaQueryWrapperX<OaWorkReportDO>()
                .in(OaWorkReportDO::getCreator, creators)
                .eq(OaWorkReportDO::getType, type)
                .eq(OaWorkReportDO::getStatus, status)
                .between(OaWorkReportDO::getStartTime, startTime, endTime)
                .orderByAsc(OaWorkReportDO::getCreator)
                .orderByAsc(OaWorkReportDO::getStartTime)
                .orderByDesc(OaWorkReportDO::getId));
    }

}
