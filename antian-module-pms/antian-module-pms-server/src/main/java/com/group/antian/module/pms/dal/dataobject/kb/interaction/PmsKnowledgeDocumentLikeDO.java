package com.group.antian.module.pms.dal.dataobject.kb.interaction;

import com.group.antian.framework.mybatis.core.dataobject.BaseDO;
import com.group.antian.module.pms.dal.dataobject.kb.content.PmsKnowledgeDocumentDO;
import com.group.antian.module.system.api.user.dto.AdminUserRespDTO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * PMS 知识文档点赞 DO
 *
 * @author 安天源码
 */
@TableName("pms_knowledge_document_like")
@KeySequence("pms_knowledge_document_like_seq")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class PmsKnowledgeDocumentLikeDO extends BaseDO {

    /**
     * 点赞编号
     */
    @TableId
    private Long id;
    /**
     * 文档编号
     *
     * 关联 {@link PmsKnowledgeDocumentDO#getId()}
     */
    private Long documentId;
    /**
     * 点赞人用户编号
     *
     * 关联 {@link AdminUserRespDTO#getId()}
     */
    private Long userId;

}
