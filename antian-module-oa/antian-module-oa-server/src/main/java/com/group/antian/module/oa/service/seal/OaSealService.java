package com.group.antian.module.oa.service.seal;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.module.oa.controller.admin.seal.vo.*;
import com.group.antian.module.oa.dal.dataobject.seal.OaSealDO;
import jakarta.validation.Valid;

/**
 * 印章 Service 接口
 *
 * @author 安天源码
 */
public interface OaSealService {

    /**
     * 创建印章
     *
     * @param createReqVO 印章信息
     * @return 编号
     */
    Long createSeal(@Valid OaSealSaveReqVO createReqVO);

    /**
     * 更新印章
     *
     * @param updateReqVO 印章信息
     */
    void updateSeal(@Valid OaSealSaveReqVO updateReqVO);

    /**
     * 删除印章
     *
     * @param id 印章编号
     */
    void deleteSeal(Long id);

    /**
     * 获得印章分页
     *
     * @param pageReqVO 分页查询
     * @return 印章分页
     */
    PageResult<OaSealDO> getSealPage(OaSealPageReqVO pageReqVO);

    /**
     * 校验印章存在
     *
     * @param id 编号
     * @return 印章
     */
    OaSealDO validateSealExists(Long id);

}
