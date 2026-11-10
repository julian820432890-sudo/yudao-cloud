package com.group.antian.module.infra.seatademo;

import com.group.antian.framework.tenant.core.db.TenantBaseDO;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

/**
 * 分布式事务示例账户 DO
 *
 * 位于 antian_seata_account 演示库，对应 seata_account 数据源
 *
 * @author 安天源码
 */
@TableName("demo_seata_account")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DemoSeataAccountDO extends TenantBaseDO {

    /**
     * 账户编号
     */
    @TableId
    private Long id;
    /**
     * 用户编号
     *
     * 同一个租户下唯一
     */
    private Long userId;
    /**
     * 余额，单位：分
     */
    private Integer balance;

}
