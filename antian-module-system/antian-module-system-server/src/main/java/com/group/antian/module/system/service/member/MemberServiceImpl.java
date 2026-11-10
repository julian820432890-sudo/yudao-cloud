package com.group.antian.module.system.service.member;

import org.springframework.stereotype.Service;

/** 系统管理分支不提供商城会员，后台用户仍通过 AdminUserService 查询。 */
@Service
public class MemberServiceImpl implements MemberService {
    @Override
    public String getMemberUserMobile(Long id) { return null; }
    @Override
    public String getMemberUserEmail(Long id) { return null; }
}
