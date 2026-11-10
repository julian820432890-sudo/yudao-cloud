package com.group.antian.module.oa.dal.mysql.resign;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.controller.admin.resign.vo.OaResignApplyPageReqVO;
import com.group.antian.module.oa.dal.dataobject.resign.OaResignApplyDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * OA 离职申请 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaResignApplyMapper extends BaseMapperX<OaResignApplyDO> {

    default PageResult<OaResignApplyDO> selectPage(Long userId, OaResignApplyPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<OaResignApplyDO>()
                .eq(OaResignApplyDO::getCreator, userId.toString())
                .likeIfPresent(OaResignApplyDO::getTitle, reqVO.getTitle())
                .eqIfPresent(OaResignApplyDO::getStatus, reqVO.getStatus())
                .orderByDesc(OaResignApplyDO::getCreateTime, OaResignApplyDO::getId));
    }

}
