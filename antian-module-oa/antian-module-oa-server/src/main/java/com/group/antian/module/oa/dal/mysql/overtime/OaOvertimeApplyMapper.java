package com.group.antian.module.oa.dal.mysql.overtime;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.controller.admin.overtime.vo.OaOvertimeApplyPageReqVO;
import com.group.antian.module.oa.dal.dataobject.overtime.OaOvertimeApplyDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * OA 加班申请 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaOvertimeApplyMapper extends BaseMapperX<OaOvertimeApplyDO> {

    default PageResult<OaOvertimeApplyDO> selectPage(Long userId, OaOvertimeApplyPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<OaOvertimeApplyDO>()
                .eq(OaOvertimeApplyDO::getCreator, userId.toString())
                .likeIfPresent(OaOvertimeApplyDO::getTitle, reqVO.getTitle())
                .eqIfPresent(OaOvertimeApplyDO::getStatus, reqVO.getStatus())
                .orderByDesc(OaOvertimeApplyDO::getCreateTime, OaOvertimeApplyDO::getId));
    }

}
