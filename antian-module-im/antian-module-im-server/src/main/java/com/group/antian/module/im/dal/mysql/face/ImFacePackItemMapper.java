package com.group.antian.module.im.dal.mysql.face;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.im.controller.admin.manager.face.vo.item.ImFacePackItemPageReqVO;
import com.group.antian.module.im.dal.dataobject.face.ImFacePackItemDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;

/**
 * IM 表情包项 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface ImFacePackItemMapper extends BaseMapperX<ImFacePackItemDO> {

    default List<ImFacePackItemDO> selectListByPackIdsAndStatus(Collection<Long> packIds, Integer status) {
        return selectList(new LambdaQueryWrapperX<ImFacePackItemDO>()
                .in(ImFacePackItemDO::getPackId, packIds)
                .eq(ImFacePackItemDO::getStatus, status)
                .orderByAsc(ImFacePackItemDO::getPackId)
                .orderByAsc(ImFacePackItemDO::getSort)
                .orderByAsc(ImFacePackItemDO::getId));
    }

    default Long selectCountByPackId(Long packId) {
        return selectCount(new LambdaQueryWrapperX<ImFacePackItemDO>()
                .eq(ImFacePackItemDO::getPackId, packId));
    }

    default Long selectCountByPackIds(Collection<Long> packIds) {
        return selectCount(new LambdaQueryWrapperX<ImFacePackItemDO>()
                .in(ImFacePackItemDO::getPackId, packIds));
    }

    default PageResult<ImFacePackItemDO> selectPage(ImFacePackItemPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<ImFacePackItemDO>()
                .eqIfPresent(ImFacePackItemDO::getPackId, reqVO.getPackId())
                .likeIfPresent(ImFacePackItemDO::getName, reqVO.getName())
                .eqIfPresent(ImFacePackItemDO::getStatus, reqVO.getStatus())
                .orderByAsc(ImFacePackItemDO::getSort)
                .orderByDesc(ImFacePackItemDO::getId));
    }

}
