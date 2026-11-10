package com.group.antian.module.mes.dal.mysql.pro.card;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.mes.controller.admin.pro.card.vo.MesProCardPageReqVO;
import com.group.antian.module.mes.dal.dataobject.pro.card.MesProCardDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 生产流转卡 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesProCardMapper extends BaseMapperX<MesProCardDO> {

    default PageResult<MesProCardDO> selectPage(MesProCardPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesProCardDO>()
                .likeIfPresent(MesProCardDO::getCode, reqVO.getCode())
                .eqIfPresent(MesProCardDO::getWorkOrderId, reqVO.getWorkOrderId())
                .eqIfPresent(MesProCardDO::getItemId, reqVO.getItemId())
                .likeIfPresent(MesProCardDO::getBatchCode, reqVO.getBatchCode())
                .orderByDesc(MesProCardDO::getId));
    }

    default MesProCardDO selectByCode(String code) {
        return selectOne(MesProCardDO::getCode, code);
    }

}
