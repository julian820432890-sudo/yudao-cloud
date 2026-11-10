package com.group.antian.module.mes.dal.mysql.md.workstation;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.mes.controller.admin.md.workstation.vo.workshop.MesMdWorkshopPageReqVO;
import com.group.antian.module.mes.dal.dataobject.md.workstation.MesMdWorkshopDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * MES 车间 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface MesMdWorkshopMapper extends BaseMapperX<MesMdWorkshopDO> {

    default PageResult<MesMdWorkshopDO> selectPage(MesMdWorkshopPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesMdWorkshopDO>()
                .eqIfPresent(MesMdWorkshopDO::getCode, reqVO.getCode())
                .likeIfPresent(MesMdWorkshopDO::getName, reqVO.getName())
                .eqIfPresent(MesMdWorkshopDO::getStatus, reqVO.getStatus())
                .orderByDesc(MesMdWorkshopDO::getId));
    }

    default MesMdWorkshopDO selectByCode(String code) {
        return selectOne(MesMdWorkshopDO::getCode, code);
    }

    default MesMdWorkshopDO selectByName(String name) {
        return selectOne(MesMdWorkshopDO::getName, name);
    }

    default List<MesMdWorkshopDO> selectListByStatus(Integer status) {
        return selectList(MesMdWorkshopDO::getStatus, status);
    }

}
