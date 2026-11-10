package com.group.antian.module.crm.dal.mysql.customer;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.crm.dal.dataobject.customer.CrmCustomerPoolConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 客户公海配置 Mapper
 *
 * @author Wanwan
 */
@Mapper
public interface CrmCustomerPoolConfigMapper extends BaseMapperX<CrmCustomerPoolConfigDO> {

    default CrmCustomerPoolConfigDO selectOne() {
        return selectFirstOne(new LambdaQueryWrapperX<CrmCustomerPoolConfigDO>()
                .orderByAsc(CrmCustomerPoolConfigDO::getId));
    }

}
