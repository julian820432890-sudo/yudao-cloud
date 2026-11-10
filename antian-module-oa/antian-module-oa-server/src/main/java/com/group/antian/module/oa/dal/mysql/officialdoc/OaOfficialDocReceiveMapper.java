package com.group.antian.module.oa.dal.mysql.officialdoc;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.oa.controller.admin.officialdoc.vo.receive.OaOfficialDocReceivePageReqVO;
import com.group.antian.module.oa.dal.dataobject.officialdoc.OaOfficialDocReceiveDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * OA 公文收文 Mapper
 *
 * @author 安天源码
 */
@Mapper
public interface OaOfficialDocReceiveMapper extends BaseMapperX<OaOfficialDocReceiveDO> {

    default OaOfficialDocReceiveDO selectByNo(String no) {
        return selectOne(OaOfficialDocReceiveDO::getNo, no);
    }

    default PageResult<OaOfficialDocReceiveDO> selectPage(Long deptId, OaOfficialDocReceivePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<OaOfficialDocReceiveDO>()
                .eq(OaOfficialDocReceiveDO::getReceiveDeptId, deptId)
                .likeIfPresent(OaOfficialDocReceiveDO::getTitle, reqVO.getTitle())
                .likeIfPresent(OaOfficialDocReceiveDO::getDocumentNo, reqVO.getDocumentNo())
                .eqIfPresent(OaOfficialDocReceiveDO::getStatus, reqVO.getStatus()).orderByDesc(OaOfficialDocReceiveDO::getId));
    }

    default List<OaOfficialDocReceiveDO> selectListBySendId(Long sendId) {
        return selectList(OaOfficialDocReceiveDO::getSendId, sendId);
    }

}
