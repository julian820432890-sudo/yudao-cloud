package com.group.antian.module.oa.dal.mysql.contact;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.dal.dataobject.contact.OaContactCategoryDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * OA 联系人分类 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaContactCategoryMapper extends BaseMapperX<OaContactCategoryDO> {

    default List<OaContactCategoryDO> selectListByUserId(Long userId) {
        return selectList(new LambdaQueryWrapperX<OaContactCategoryDO>()
                .eq(OaContactCategoryDO::getUserId, userId)
                .orderByAsc(OaContactCategoryDO::getSort)
                .orderByAsc(OaContactCategoryDO::getId));
    }

    default OaContactCategoryDO selectByUserIdAndName(Long userId, String name) {
        return selectOne(OaContactCategoryDO::getUserId, userId, OaContactCategoryDO::getName, name);
    }

}
