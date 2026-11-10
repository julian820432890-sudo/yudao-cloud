package com.group.antian.module.oa.dal.mysql.regular;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.controller.admin.regular.vo.OaRegularApplyPageReqVO;
import com.group.antian.module.oa.dal.dataobject.regular.OaRegularApplyDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * OA 转正申请 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaRegularApplyMapper extends BaseMapperX<OaRegularApplyDO> {

    default PageResult<OaRegularApplyDO> selectPage(Long userId, OaRegularApplyPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<OaRegularApplyDO>()
                .eq(OaRegularApplyDO::getCreator, userId.toString())
                .likeIfPresent(OaRegularApplyDO::getTitle, reqVO.getTitle())
                .eqIfPresent(OaRegularApplyDO::getStatus, reqVO.getStatus())
                .orderByDesc(OaRegularApplyDO::getCreateTime, OaRegularApplyDO::getId));
    }

}
