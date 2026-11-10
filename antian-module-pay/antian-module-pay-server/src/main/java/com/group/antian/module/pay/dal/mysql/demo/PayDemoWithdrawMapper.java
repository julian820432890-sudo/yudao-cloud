package com.group.antian.module.pay.dal.mysql.demo;

import com.group.antian.framework.common.pojo.PageParam;
import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.pay.dal.dataobject.demo.PayDemoWithdrawDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PayDemoWithdrawMapper extends BaseMapperX<PayDemoWithdrawDO> {

    default  PageResult<PayDemoWithdrawDO> selectPage(PageParam pageParam){
        return selectPage(pageParam, new LambdaQueryWrapperX<PayDemoWithdrawDO>()
                .orderByDesc(PayDemoWithdrawDO::getId));
    }

    default int updateByIdAndStatus(Long id, Integer whereStatus, PayDemoWithdrawDO updateObj) {
        return update(updateObj, new LambdaQueryWrapperX<PayDemoWithdrawDO>()
                .eq(PayDemoWithdrawDO::getId, id)
                .eq(PayDemoWithdrawDO::getStatus, whereStatus));
    }

}