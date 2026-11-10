package com.group.antian.module.pay.convert.wallet;

import com.group.antian.framework.common.pojo.PageResult;
import com.group.antian.module.pay.controller.admin.wallet.vo.transaction.PayWalletTransactionRespVO;
import com.group.antian.module.pay.controller.app.wallet.vo.transaction.AppPayWalletTransactionRespVO;
import com.group.antian.module.pay.dal.dataobject.wallet.PayWalletTransactionDO;
import com.group.antian.module.pay.service.wallet.bo.WalletTransactionCreateReqBO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PayWalletTransactionConvert {

    PayWalletTransactionConvert INSTANCE = Mappers.getMapper(PayWalletTransactionConvert.class);

    PageResult<PayWalletTransactionRespVO> convertPage2(PageResult<PayWalletTransactionDO> page);

    PayWalletTransactionDO convert(WalletTransactionCreateReqBO bean);

}
