package com.group.antian.module.oa.dal.mysql.vehicle;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.MPJLambdaWrapperX;
import com.group.antian.module.oa.dal.dataobject.vehicle.OaVehicleApplyDO;
import com.group.antian.module.oa.dal.dataobject.vehicle.OaVehicleDO;
import com.group.antian.module.oa.controller.admin.vehicle.vo.returning.OaVehicleReturnPageReqVO;
import com.group.antian.module.oa.dal.dataobject.vehicle.OaVehicleReturnDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * OA 还车申请 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaVehicleReturnMapper extends BaseMapperX<OaVehicleReturnDO> {

    default OaVehicleReturnDO selectByNo(String no) {
        return selectOne(OaVehicleReturnDO::getNo, no);
    }

    default PageResult<OaVehicleReturnDO> selectPage(Long userId, OaVehicleReturnPageReqVO reqVO) {
        MPJLambdaWrapperX<OaVehicleReturnDO> query = new MPJLambdaWrapperX<OaVehicleReturnDO>()
                .selectAll(OaVehicleReturnDO.class)
                .leftJoin(OaVehicleApplyDO.class, OaVehicleApplyDO::getId, OaVehicleReturnDO::getApplyId)
                .leftJoin(OaVehicleDO.class, OaVehicleDO::getId, OaVehicleReturnDO::getVehicleId)
                .eq(OaVehicleReturnDO::getUserId, userId)
                .likeIfPresent(OaVehicleReturnDO::getNo, reqVO.getNo())
                .eqIfPresent(OaVehicleReturnDO::getApplyId, reqVO.getApplyId())
                .eqIfPresent(OaVehicleReturnDO::getStatus, reqVO.getStatus())
                .likeIfPresent(OaVehicleDO::getNo, reqVO.getVehicleNo())
                .likeIfPresent(OaVehicleApplyDO::getNo, reqVO.getApplyNo())
                .eqIfPresent(OaVehicleReturnDO::getDeptId, reqVO.getDeptId())
                .betweenIfPresent(OaVehicleReturnDO::getCreateTime, reqVO.getCreateTime());
        query.orderByDesc(OaVehicleReturnDO::getId);
        return selectJoinPage(reqVO, OaVehicleReturnDO.class, query);
    }

}
