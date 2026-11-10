package com.group.antian.module.hrm.dal.mysql.employee.experience;

import com.group.antian.framework.mybatis.core.mapper.BaseMapperX;
import com.group.antian.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.group.antian.module.hrm.dal.dataobject.employee.experience.HrmEmployeeCertificateDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HrmEmployeeCertificateMapper extends BaseMapperX<HrmEmployeeCertificateDO> {

    default List<HrmEmployeeCertificateDO> selectListByEmployeeId(Long employeeId) {
        return selectList(new LambdaQueryWrapperX<HrmEmployeeCertificateDO>()
                .eq(HrmEmployeeCertificateDO::getEmployeeId, employeeId)
                .orderByAsc(HrmEmployeeCertificateDO::getSort)
                .orderByDesc(HrmEmployeeCertificateDO::getId));
    }

}
