package com.group.antian.module.fms.dal.mysql.config;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.fms.dal.dataobject.config.FmsVoucherTemplateCategoryDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 凭证模板分类 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface FmsVoucherTemplateCategoryMapper extends BaseMapperX<FmsVoucherTemplateCategoryDO> {

    default List<FmsVoucherTemplateCategoryDO> selectListByAccountSetId(Long accountSetId) {
        return selectList(new LambdaQueryWrapperX<FmsVoucherTemplateCategoryDO>()
                .eq(FmsVoucherTemplateCategoryDO::getAccountSetId, accountSetId)
                .orderByAsc(FmsVoucherTemplateCategoryDO::getId));
    }

    default FmsVoucherTemplateCategoryDO selectByAccountSetIdAndName(Long accountSetId, String name) {
        return selectOne(FmsVoucherTemplateCategoryDO::getAccountSetId, accountSetId,
                FmsVoucherTemplateCategoryDO::getName, name);
    }

}
