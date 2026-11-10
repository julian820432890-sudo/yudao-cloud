package com.group.antian.module.oa.dal.mysql.mail;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.mail.OaMailAccountDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * OA 企业邮箱账号 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaMailAccountMapper extends BaseMapperX<OaMailAccountDO> {

    default List<OaMailAccountDO> selectListByStatus(Integer status) {
        return selectList(new LambdaQueryWrapperX<OaMailAccountDO>()
                .select(OaMailAccountDO::getMail, OaMailAccountDO::getCreator).eq(OaMailAccountDO::getStatus, status)
                .orderByAsc(OaMailAccountDO::getMail).orderByAsc(OaMailAccountDO::getId));
    }

    default OaMailAccountDO selectByIdForUpdate(Long id) {
        return selectOneForUpdate(OaMailAccountDO::getId, id);
    }

    default List<OaMailAccountDO> selectListByCreatorAndStatus(String creator, Integer status) {
        return selectList(new LambdaQueryWrapperX<OaMailAccountDO>().eq(OaMailAccountDO::getCreator, creator)
                .eqIfPresent(OaMailAccountDO::getStatus, status)
                .orderByDesc(OaMailAccountDO::getDefaultStatus).orderByAsc(OaMailAccountDO::getId));
    }

    default List<OaMailAccountDO> selectListByCreatorForUpdate(String creator) {
        return selectListForUpdate(new LambdaQueryWrapperX<OaMailAccountDO>().eq(OaMailAccountDO::getCreator, creator)
                .orderByAsc(OaMailAccountDO::getId));
    }

    default Long selectCountByProviderId(Long providerId) {
        return selectCount(OaMailAccountDO::getProviderId, providerId);
    }

}
