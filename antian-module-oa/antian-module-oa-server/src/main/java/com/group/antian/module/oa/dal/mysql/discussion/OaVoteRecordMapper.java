package com.group.antian.module.oa.dal.mysql.discussion;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.discussion.OaVoteRecordDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;

/**
 * OA 投票记录 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaVoteRecordMapper extends BaseMapperX<OaVoteRecordDO> {

    default List<OaVoteRecordDO> selectListByDiscussionIds(Collection<Long> discussionIds) {
        return selectList(new LambdaQueryWrapperX<OaVoteRecordDO>()
                .in(OaVoteRecordDO::getDiscussionId, discussionIds));
    }

    default List<OaVoteRecordDO> selectListByDiscussionIdAndUserId(Long discussionId, Long userId) {
        return selectList(OaVoteRecordDO::getDiscussionId, discussionId, OaVoteRecordDO::getUserId, userId);
    }

    default void deleteByDiscussionId(Long discussionId) {
        delete(OaVoteRecordDO::getDiscussionId, discussionId);
    }

}
