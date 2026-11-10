package com.group.antian.module.hrm.dal.mysql.salary.config;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.hrm.dal.dataobject.salary.config.HrmSalaryConfigDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HrmSalaryConfigMapper extends BaseMapperX<HrmSalaryConfigDO> {

    default HrmSalaryConfigDO selectFirst() {
        return selectFirstOne(new LambdaQueryWrapperX<HrmSalaryConfigDO>()
                .orderByAsc(HrmSalaryConfigDO::getId));
    }

}
