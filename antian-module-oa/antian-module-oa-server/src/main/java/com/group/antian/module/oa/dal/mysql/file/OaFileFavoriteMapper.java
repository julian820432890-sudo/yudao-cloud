package com.group.antian.module.oa.dal.mysql.file;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.file.OaFileFavoriteDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;

/**
 * OA 云盘收藏 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaFileFavoriteMapper extends BaseMapperX<OaFileFavoriteDO> {

    default List<OaFileFavoriteDO> selectListByUserId(Long userId) {
        return selectList(OaFileFavoriteDO::getUserId, userId);
    }

    default List<OaFileFavoriteDO> selectListByUserIdAndNodeIds(Long userId, Collection<Long> nodeIds) {
        return selectList(new LambdaQueryWrapperX<OaFileFavoriteDO>()
                .eq(OaFileFavoriteDO::getUserId, userId).in(OaFileFavoriteDO::getNodeId, nodeIds));
    }

    default OaFileFavoriteDO selectByUserIdAndNodeId(Long userId, Long nodeId) {
        return selectOne(OaFileFavoriteDO::getUserId, userId, OaFileFavoriteDO::getNodeId, nodeId);
    }

    default void deleteByNodeIds(Collection<Long> nodeIds) {
        delete(new LambdaQueryWrapperX<OaFileFavoriteDO>().in(OaFileFavoriteDO::getNodeId, nodeIds));
    }

    default void deleteByNodeIdAndUserId(Long nodeId, Long userId) {
        delete(new LambdaQueryWrapperX<OaFileFavoriteDO>()
                .eq(OaFileFavoriteDO::getNodeId, nodeId).eq(OaFileFavoriteDO::getUserId, userId));
    }
}
