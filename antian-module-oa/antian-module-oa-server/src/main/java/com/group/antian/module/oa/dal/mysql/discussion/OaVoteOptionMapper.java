package com.group.antian.module.oa.dal.mysql.discussion;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.discussion.OaVoteOptionDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collection;
import java.util.List;

/**
 * OA 投票选项 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaVoteOptionMapper extends BaseMapperX<OaVoteOptionDO> {

    default List<OaVoteOptionDO> selectListByDiscussionIds(Collection<Long> discussionIds) {
        return selectList(new LambdaQueryWrapperX<OaVoteOptionDO>()
                .in(OaVoteOptionDO::getDiscussionId, discussionIds)
                .orderByAsc(OaVoteOptionDO::getSort)
                .orderByAsc(OaVoteOptionDO::getId));
    }

    default void deleteByDiscussionId(Long discussionId) {
        delete(OaVoteOptionDO::getDiscussionId, discussionId);
    }

}
