package com.group.antian.module.mes.dal.mysql.qc.template;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.framework.mybatis.core.util.MyBatisUtils;
import com.group.antian.module.mes.controller.admin.qc.template.vo.MesQcTemplatePageReqVO;
import com.group.antian.module.mes.dal.dataobject.qc.template.MesQcTemplateDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * MES 质检方案 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesQcTemplateMapper extends BaseMapperX<MesQcTemplateDO> {

    default PageResult<MesQcTemplateDO> selectPage(MesQcTemplatePageReqVO reqVO) {
        LambdaQueryWrapperX<MesQcTemplateDO> query = new LambdaQueryWrapperX<MesQcTemplateDO>()
                .likeIfPresent(MesQcTemplateDO::getCode, reqVO.getCode())
                .likeIfPresent(MesQcTemplateDO::getName, reqVO.getName())
                .orderByDesc(MesQcTemplateDO::getId);
        if (reqVO.getType() != null) {
            query.apply(MyBatisUtils.findInSet("types"), reqVO.getType());
        }
        query.eqIfPresent(MesQcTemplateDO::getStatus, reqVO.getStatus());
        return selectPage(reqVO, query);
    }

    default MesQcTemplateDO selectByCode(String code) {
        return selectOne(MesQcTemplateDO::getCode, code);
    }

    default List<MesQcTemplateDO> selectList() {
        return selectList(new LambdaQueryWrapperX<MesQcTemplateDO>()
                .orderByDesc(MesQcTemplateDO::getId));
    }

}
