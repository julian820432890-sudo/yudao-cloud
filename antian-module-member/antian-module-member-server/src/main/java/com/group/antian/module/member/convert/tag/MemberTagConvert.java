package com.group.antian.module.member.convert.tag;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.module.member.controller.admin.tag.vo.MemberTagCreateReqVO;
import com.group.antian.module.member.controller.admin.tag.vo.MemberTagRespVO;
import com.group.antian.module.member.controller.admin.tag.vo.MemberTagUpdateReqVO;
import com.group.antian.module.member.dal.dataobject.tag.MemberTagDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 会员标签 Convert
 *
 * @author 安天源码
 */
@Mapper
public interface MemberTagConvert {

    MemberTagConvert INSTANCE = Mappers.getMapper(MemberTagConvert.class);

    MemberTagDO convert(MemberTagCreateReqVO bean);

    MemberTagDO convert(MemberTagUpdateReqVO bean);

    MemberTagRespVO convert(MemberTagDO bean);

    List<MemberTagRespVO> convertList(List<MemberTagDO> list);

    PageResult<MemberTagRespVO> convertPage(PageResult<MemberTagDO> page);

}
