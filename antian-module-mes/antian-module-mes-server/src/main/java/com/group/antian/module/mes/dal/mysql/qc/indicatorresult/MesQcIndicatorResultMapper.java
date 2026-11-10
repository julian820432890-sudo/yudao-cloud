package com.group.antian.module.mes.dal.mysql.qc.indicatorresult;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.mes.controller.admin.qc.indicatorresult.vo.MesQcIndicatorResultPageReqVO;
import com.group.antian.module.mes.dal.dataobject.qc.indicatorresult.MesQcIndicatorResultDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 检验结果记录 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesQcIndicatorResultMapper extends BaseMapperX<MesQcIndicatorResultDO> {

    default PageResult<MesQcIndicatorResultDO> selectPage(MesQcIndicatorResultPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesQcIndicatorResultDO>()
                .eqIfPresent(MesQcIndicatorResultDO::getQcId, reqVO.getQcId())
                .eqIfPresent(MesQcIndicatorResultDO::getQcType, reqVO.getQcType())
                .likeIfPresent(MesQcIndicatorResultDO::getCode, reqVO.getCode())
                .eqIfPresent(MesQcIndicatorResultDO::getItemId, reqVO.getItemId())
                .orderByDesc(MesQcIndicatorResultDO::getId));
    }

    default Long selectCountByQcIdAndType(Long qcId, Integer qcType) {
        return selectCount(new LambdaQueryWrapperX<MesQcIndicatorResultDO>()
                .eq(MesQcIndicatorResultDO::getQcId, qcId)
                .eq(MesQcIndicatorResultDO::getQcType, qcType));
    }

}
