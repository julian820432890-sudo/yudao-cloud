package com.group.antian.module.iot.controller.admin.rule.vo.data.sink;

import com.group.antian.framework.common.enums.CommonStatusEnum;
import com.group.antian.module.iot.dal.dataobject.rule.config.IotAbstractDataSinkConfig;
import com.group.antian.module.iot.dal.dataobject.rule.config.IotDataSinkDatabaseConfig;
import com.group.antian.module.iot.dal.dataobject.rule.config.IotDataSinkHttpConfig;
import com.group.antian.module.iot.enums.rule.IotDataSinkTypeEnum;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * {@link IotDataSinkSaveReqVO} 的参数校验单元测试
 *
 * @author 安天源码
 */
public class IotDataSinkSaveReqVOTest {

    private final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    @Test
    public void testValidate_databaseTableNameValid() {
        for (String tableName : Arrays.asList("iot_device_message", "iot_data.device_message")) {
            // 准备参数
            IotDataSinkSaveReqVO reqVO = buildReqVO(IotDataSinkTypeEnum.DATABASE.getType(), buildDatabaseConfig(tableName));

            // 调用，并断言
            assertTrue(validator.validate(reqVO).isEmpty(), tableName);
        }
    }

    @Test
    public void testValidate_databaseTableNameInvalid() {
        for (String tableName : Arrays.asList(null, "", "1message", "message; DROP TABLE system_users",
                "message -- ", "message/**/", "`message`", "a.b.c", "message(id)")) {
            // 准备参数
            IotDataSinkSaveReqVO reqVO = buildReqVO(IotDataSinkTypeEnum.DATABASE.getType(), buildDatabaseConfig(tableName));

            // 调用
            Set<ConstraintViolation<IotDataSinkSaveReqVO>> violations = validator.validate(reqVO);
            // 断言：通过 @Valid 级联校验到配置的表名
            assertTrue(!violations.isEmpty(), String.valueOf(tableName));
            violations.forEach(violation -> assertEquals("config.tableName", violation.getPropertyPath().toString()));
        }
    }

    @Test
    public void testValidate_otherConfigNotAffected() {
        // 准备参数：其它类型的配置，没有新增的校验约束
        IotDataSinkHttpConfig config = new IotDataSinkHttpConfig();
        config.setUrl("https://www.antianwl.com");
        IotDataSinkSaveReqVO reqVO = buildReqVO(IotDataSinkTypeEnum.HTTP.getType(), config);

        // 调用，并断言
        assertTrue(validator.validate(reqVO).isEmpty());
    }

    private static IotDataSinkSaveReqVO buildReqVO(Integer type, IotAbstractDataSinkConfig config) {
        IotDataSinkSaveReqVO reqVO = new IotDataSinkSaveReqVO();
        reqVO.setName("数据目的");
        reqVO.setStatus(CommonStatusEnum.ENABLE.getStatus());
        reqVO.setType(type);
        reqVO.setConfig(config);
        return reqVO;
    }

    private static IotDataSinkDatabaseConfig buildDatabaseConfig(String tableName) {
        IotDataSinkDatabaseConfig config = new IotDataSinkDatabaseConfig();
        config.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/iot_data");
        config.setTableName(tableName);
        return config;
    }

}
