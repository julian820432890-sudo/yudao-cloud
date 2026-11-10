package com.group.antian.module.ai.framework.ai.config;

import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.group.antian.module.ai.framework.ai.core.model.AiModelFactory;
import com.group.antian.module.ai.framework.ai.core.model.AiModelFactoryImpl;
import com.group.antian.module.ai.framework.ai.core.model.baichuan.BaiChuanChatModel;
import com.group.antian.module.ai.framework.ai.core.model.doubao.DouBaoChatModel;
import com.group.antian.module.ai.framework.ai.core.model.gemini.GeminiChatModel;
import com.group.antian.module.ai.framework.ai.core.model.grok.GrokChatModel;
import com.group.antian.module.ai.framework.ai.core.model.hunyuan.HunYuanChatModel;
import com.group.antian.module.ai.framework.ai.core.model.midjourney.api.MidjourneyApi;
import com.group.antian.module.ai.framework.ai.core.model.minimax.MiniMaxChatModel;
import com.group.antian.module.ai.framework.ai.core.model.moonshot.MoonshotChatModel;
import com.group.antian.module.ai.framework.ai.core.model.siliconflow.SiliconFlowApiConstants;
import com.group.antian.module.ai.framework.ai.core.model.siliconflow.SiliconFlowChatModel;
import com.group.antian.module.ai.framework.ai.core.model.stepfun.StepFunChatModel;
import com.group.antian.module.ai.framework.ai.core.model.suno.api.SunoApi;
import com.group.antian.module.ai.framework.ai.core.model.xinghuo.XingHuoChatModel;
import com.group.antian.module.ai.framework.ai.core.model.yiyan.YiYanChatModel;
import com.group.antian.module.ai.framework.ai.core.model.zhipu.ZhiPuChatModel;
import com.group.antian.module.ai.framework.ai.core.reasoning.AiRequestBodyPatcher;
import com.group.antian.module.ai.framework.ai.core.webserch.AiWebSearchClient;
import com.group.antian.module.ai.framework.ai.core.webserch.bocha.AiBoChaWebSearchClient;
import com.group.antian.module.ai.tool.function.DirectoryListToolFunction;
import com.group.antian.module.ai.tool.function.UserProfileQueryToolFunction;
import com.group.antian.module.ai.tool.function.WeatherQueryToolFunction;
import com.group.antian.module.ai.tool.method.PersonService;
import io.micrometer.observation.ObservationRegistry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.deepseek.DeepSeekChatModel;
import org.springframework.ai.deepseek.DeepSeekChatOptions;
import org.springframework.ai.deepseek.api.DeepSeekApi;
import org.springframework.ai.embedding.BatchingStrategy;
import org.springframework.ai.embedding.TokenCountBatchingStrategy;
import org.springframework.ai.model.tool.ToolCallingManager;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.ai.openai.api.OpenAiApi;
import org.springframework.ai.support.ToolCallbacks;
import org.springframework.ai.tokenizer.JTokkitTokenCountEstimator;
import org.springframework.ai.tokenizer.TokenCountEstimator;
import org.springframework.ai.tool.ToolCallback;
import org.springframework.ai.tool.function.FunctionToolCallback;
import org.springframework.ai.vectorstore.milvus.autoconfigure.MilvusServiceClientProperties;
import org.springframework.ai.vectorstore.milvus.autoconfigure.MilvusVectorStoreProperties;
import org.springframework.ai.vectorstore.qdrant.autoconfigure.QdrantVectorStoreProperties;
import org.springframework.ai.vectorstore.redis.autoconfigure.RedisVectorStoreProperties;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * 安天 AI 自动配置
 *
 * @author fansili
 */
@Configuration
@EnableConfigurationProperties({ AntianAiProperties.class,
        QdrantVectorStoreProperties.class, // 解析 Qdrant 配置
        RedisVectorStoreProperties.class, // 解析 Redis 配置
        MilvusVectorStoreProperties.class, MilvusServiceClientProperties.class // 解析 Milvus 配置
})
@Slf4j
public class AiAutoConfiguration {

    @Bean
    public AiModelFactory aiModelFactory() {
        return new AiModelFactoryImpl();
    }

    @Bean
    @ConditionalOnMissingBean
    public ObservationRegistry observationRegistry() {
        // 特殊：兜底有 ObservationRegistry Bean，避免相关的 ChatModel 创建报错。相关 issue：https://t.zsxq.com/CuPu4
        return ObservationRegistry.NOOP;
    }

    // ========== 各种 AI Client 创建 ==========

    @Bean
    @ConditionalOnProperty(value = "antian.ai.gemini.enable", havingValue = "true")
    public GeminiChatModel geminiChatModel(AntianAiProperties antianAiProperties) {
        AntianAiProperties.Gemini properties = antianAiProperties.getGemini();
        return buildGeminiChatClient(properties);
    }

    public GeminiChatModel buildGeminiChatClient(AntianAiProperties.Gemini properties) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(GeminiChatModel.MODEL_DEFAULT);
        }
        OpenAiChatModel openAiChatModel = OpenAiChatModel.builder()
                .openAiApi(OpenAiApi.builder()
                        .baseUrl(GeminiChatModel.BASE_URL)
                        .completionsPath(GeminiChatModel.COMPLETE_PATH)
                        .apiKey(properties.getApiKey())
                        .build())
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new GeminiChatModel(openAiChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.doubao.enable", havingValue = "true")
    public DouBaoChatModel douBaoChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.DouBao properties = antianAiProperties.getDoubao();
        return buildDouBaoChatClient(properties);
    }

    public DouBaoChatModel buildDouBaoChatClient(AntianAiProperties.DouBao properties) {
        return buildDouBaoChatClient(properties, null);
    }

    public DouBaoChatModel buildDouBaoChatClient(AntianAiProperties.DouBao properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(DouBaoChatModel.MODEL_DEFAULT);
        }
        DeepSeekChatModel openAiChatModel = DeepSeekChatModel.builder()
                .deepSeekApi(AiRequestBodyPatcher.configure(DeepSeekApi.builder()
                        .baseUrl(DouBaoChatModel.BASE_URL)
                        .completionsPath(DouBaoChatModel.COMPLETE_PATH)
                        .apiKey(properties.getApiKey()), patcher)
                        .build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new DouBaoChatModel(openAiChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.siliconflow.enable", havingValue = "true")
    public SiliconFlowChatModel siliconFlowChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.SiliconFlow properties = antianAiProperties.getSiliconflow();
        return buildSiliconFlowChatClient(properties);
    }

    public SiliconFlowChatModel buildSiliconFlowChatClient(AntianAiProperties.SiliconFlow properties) {
        return buildSiliconFlowChatClient(properties, null);
    }

    public SiliconFlowChatModel buildSiliconFlowChatClient(AntianAiProperties.SiliconFlow properties,
                                                           AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(SiliconFlowApiConstants.MODEL_DEFAULT);
        }
        DeepSeekChatModel openAiChatModel = DeepSeekChatModel.builder()
                .deepSeekApi(AiRequestBodyPatcher.configure(DeepSeekApi.builder()
                        .baseUrl(SiliconFlowApiConstants.DEFAULT_BASE_URL)
                        .apiKey(properties.getApiKey()), patcher)
                        .build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new SiliconFlowChatModel(openAiChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.hunyuan.enable", havingValue = "true")
    public HunYuanChatModel hunYuanChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.HunYuan properties = antianAiProperties.getHunyuan();
        return buildHunYuanChatClient(properties);
    }

    public HunYuanChatModel buildHunYuanChatClient(AntianAiProperties.HunYuan properties) {
        return buildHunYuanChatClient(properties, null);
    }

    public HunYuanChatModel buildHunYuanChatClient(AntianAiProperties.HunYuan properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(HunYuanChatModel.MODEL_DEFAULT);
        }
        if (StrUtil.isEmpty(properties.getBaseUrl())) {
            properties.setBaseUrl(HunYuanChatModel.BASE_URL);
        }
        // 创建 DeepSeekChatModel、HunYuanChatModel 对象
        DeepSeekChatModel openAiChatModel = DeepSeekChatModel.builder()
                .deepSeekApi(AiRequestBodyPatcher.configure(DeepSeekApi.builder()
                        .baseUrl(properties.getBaseUrl())
                        .completionsPath(HunYuanChatModel.COMPLETE_PATH)
                        .apiKey(properties.getApiKey()), patcher)
                        .build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new HunYuanChatModel(openAiChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.xinghuo.enable", havingValue = "true")
    public XingHuoChatModel xingHuoChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.XingHuo properties = antianAiProperties.getXinghuo();
        return buildXingHuoChatClient(properties);
    }

    public XingHuoChatModel buildXingHuoChatClient(AntianAiProperties.XingHuo properties) {
        return buildXingHuoChatClient(properties, null);
    }

    public XingHuoChatModel buildXingHuoChatClient(AntianAiProperties.XingHuo properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(XingHuoChatModel.MODEL_DEFAULT);
        }
        return XingHuoChatModel.builder()
                .apiKey(properties.getApiKey())
                .patcher(patcher)
                .options(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .build();
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.baichuan.enable", havingValue = "true")
    public BaiChuanChatModel baiChuanChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.BaiChuan properties = antianAiProperties.getBaichuan();
        return buildBaiChuanChatClient(properties);
    }

    public BaiChuanChatModel buildBaiChuanChatClient(AntianAiProperties.BaiChuan properties) {
        return buildBaiChuanChatClient(properties, null);
    }

    public BaiChuanChatModel buildBaiChuanChatClient(AntianAiProperties.BaiChuan properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(BaiChuanChatModel.MODEL_DEFAULT);
        }
        DeepSeekChatModel deepSeekChatModel = DeepSeekChatModel.builder()
                .deepSeekApi(AiRequestBodyPatcher.configure(DeepSeekApi.builder()
                        .baseUrl(BaiChuanChatModel.BASE_URL)
                        .apiKey(properties.getApiKey())
                        .completionsPath(BaiChuanChatModel.COMPLETE_PATH), patcher)
                        .build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new BaiChuanChatModel(deepSeekChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.yiyan.enable", havingValue = "true")
    public YiYanChatModel yiYanChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.YiYan properties = antianAiProperties.getYiyan();
        return buildYiYanChatClient(properties);
    }

    public YiYanChatModel buildYiYanChatClient(AntianAiProperties.YiYan properties) {
        return buildYiYanChatClient(properties, null);
    }

    public YiYanChatModel buildYiYanChatClient(AntianAiProperties.YiYan properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(YiYanChatModel.MODEL_DEFAULT);
        }
        return new YiYanChatModel(buildDeepSeekCompatibleChatModel(
                StrUtil.blankToDefault(properties.getBaseUrl(), YiYanChatModel.BASE_URL),
                null, properties.getApiKey(), properties.getModel(), properties.getTemperature(),
                properties.getMaxTokens(), properties.getTopP(), patcher));
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.zhipu.enable", havingValue = "true")
    public ZhiPuChatModel zhiPuChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.ZhiPu properties = antianAiProperties.getZhipu();
        return buildZhiPuChatClient(properties);
    }

    public ZhiPuChatModel buildZhiPuChatClient(AntianAiProperties.ZhiPu properties) {
        return buildZhiPuChatClient(properties, null);
    }

    public ZhiPuChatModel buildZhiPuChatClient(AntianAiProperties.ZhiPu properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(ZhiPuChatModel.MODEL_DEFAULT);
        }
        DeepSeekChatModel deepSeekChatModel = DeepSeekChatModel.builder()
                .deepSeekApi(AiRequestBodyPatcher.configure(DeepSeekApi.builder()
                        .baseUrl(StrUtil.blankToDefault(properties.getBaseUrl(), ZhiPuChatModel.BASE_URL))
                        .apiKey(properties.getApiKey()), patcher)
                        .build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .build();
        return new ZhiPuChatModel(deepSeekChatModel);
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.minimax.enable", havingValue = "true")
    public MiniMaxChatModel miniMaxChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.MiniMax properties = antianAiProperties.getMinimax();
        return buildMiniMaxChatClient(properties);
    }

    public MiniMaxChatModel buildMiniMaxChatClient(AntianAiProperties.MiniMax properties) {
        return buildMiniMaxChatClient(properties, null);
    }

    public MiniMaxChatModel buildMiniMaxChatClient(AntianAiProperties.MiniMax properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(MiniMaxChatModel.MODEL_DEFAULT);
        }
        return new MiniMaxChatModel(buildDeepSeekCompatibleChatModel(
                StrUtil.blankToDefault(properties.getBaseUrl(), MiniMaxChatModel.BASE_URL),
                null, properties.getApiKey(), properties.getModel(), properties.getTemperature(),
                properties.getMaxTokens(), properties.getTopP(), patcher));
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.moonshot.enable", havingValue = "true")
    public MoonshotChatModel moonshotChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.Moonshot properties = antianAiProperties.getMoonshot();
        return buildMoonshotChatClient(properties);
    }

    public MoonshotChatModel buildMoonshotChatClient(AntianAiProperties.Moonshot properties) {
        return buildMoonshotChatClient(properties, null);
    }

    public MoonshotChatModel buildMoonshotChatClient(AntianAiProperties.Moonshot properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(MoonshotChatModel.MODEL_DEFAULT);
        }
        return new MoonshotChatModel(buildDeepSeekCompatibleChatModel(
                StrUtil.blankToDefault(properties.getBaseUrl(), MoonshotChatModel.BASE_URL),
                MoonshotChatModel.COMPLETE_PATH, properties.getApiKey(), properties.getModel(),
                properties.getTemperature(), properties.getMaxTokens(), properties.getTopP(), patcher));
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.stepfun.enable", havingValue = "true")
    public StepFunChatModel stepFunChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.StepFun properties = antianAiProperties.getStepfun();
        return buildStepFunChatClient(properties);
    }

    public StepFunChatModel buildStepFunChatClient(AntianAiProperties.StepFun properties) {
        return buildStepFunChatClient(properties, null);
    }

    public StepFunChatModel buildStepFunChatClient(AntianAiProperties.StepFun properties, AiRequestBodyPatcher patcher) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(StepFunChatModel.MODEL_DEFAULT);
        }
        return new StepFunChatModel(buildDeepSeekCompatibleChatModel(
                StrUtil.blankToDefault(properties.getBaseUrl(), StepFunChatModel.BASE_URL),
                StepFunChatModel.COMPLETE_PATH, properties.getApiKey(), properties.getModel(),
                properties.getTemperature(), properties.getMaxTokens(), properties.getTopP(), patcher));
    }

    private static DeepSeekChatModel buildDeepSeekCompatibleChatModel(String baseUrl, String completionsPath,
                                                                     String apiKey, String model,
                                                                     Double temperature, Integer maxTokens,
                                                                     Double topP, AiRequestBodyPatcher patcher) {
        DeepSeekApi.Builder apiBuilder = DeepSeekApi.builder()
                .baseUrl(baseUrl)
                .apiKey(apiKey);
        if (StrUtil.isNotEmpty(completionsPath)) {
            apiBuilder.completionsPath(completionsPath);
        }
        AiRequestBodyPatcher.configure(apiBuilder, patcher);
        return DeepSeekChatModel.builder()
                .deepSeekApi(apiBuilder.build())
                .defaultOptions(DeepSeekChatOptions.builder()
                        .model(model)
                        .temperature(temperature)
                        .maxTokens(maxTokens)
                        .topP(topP)
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.midjourney.enable", havingValue = "true")
    public MidjourneyApi midjourneyApi(AntianAiProperties antianAiProperties) {
        AntianAiProperties.Midjourney config = antianAiProperties.getMidjourney();
        return new MidjourneyApi(config.getBaseUrl(), config.getApiKey(), config.getNotifyUrl());
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.suno.enable", havingValue = "true")
    public SunoApi sunoApi(AntianAiProperties antianAiProperties) {
        return new SunoApi(antianAiProperties.getSuno().getBaseUrl());
    }

    @Bean
    @ConditionalOnProperty(value = "antian.ai.grok.enable", havingValue = "true")
    public GrokChatModel grokChatClient(AntianAiProperties antianAiProperties) {
        AntianAiProperties.Grok properties = antianAiProperties.getGrok();
        return buildGrokChatClient(properties);
    }

    public GrokChatModel buildGrokChatClient(AntianAiProperties.Grok properties) {
        if (StrUtil.isEmpty(properties.getModel())) {
            properties.setModel(GrokChatModel.MODEL_DEFAULT);
        }
        OpenAiChatModel openAiChatModel = OpenAiChatModel.builder()
                .openAiApi(OpenAiApi.builder()
                        .baseUrl(StrUtil.blankToDefault(properties.getBaseUrl(), GrokChatModel.BASE_URL))
                        .completionsPath(GrokChatModel.COMPLETE_PATH)
                        .apiKey(properties.getApiKey())
                        .build())
                .defaultOptions(OpenAiChatOptions.builder()
                        .model(properties.getModel())
                        .temperature(properties.getTemperature())
                        .maxTokens(properties.getMaxTokens())
                        .topP(properties.getTopP())
                        .build())
                .toolCallingManager(getToolCallingManager())
                .build();
        return new GrokChatModel(openAiChatModel);
    }

    // ========== RAG 相关 ==========

    @Bean
    public TokenCountEstimator tokenCountEstimator() {
        return new JTokkitTokenCountEstimator();
    }

    @Bean
    public BatchingStrategy batchingStrategy() {
        return new TokenCountBatchingStrategy();
    }

    private static ToolCallingManager getToolCallingManager() {
        return SpringUtil.getBean(ToolCallingManager.class);
    }

    // ========== Web Search 相关 ==========

    @Bean
    @ConditionalOnProperty(value = "antian.ai.web-search.enable", havingValue = "true")
    public AiWebSearchClient webSearchClient(AntianAiProperties antianAiProperties) {
        return new AiBoChaWebSearchClient(antianAiProperties.getWebSearch().getApiKey());
    }

    // ========== MCP & 工具相关 ==========

    /**
     * 参考自 <a href="https://docs.spring.io/spring-ai/reference/api/mcp/mcp-client-boot-starter-docs.html">MCP Server Boot Starter</>
     */
    @Bean
    public List<ToolCallback> toolCallbacks(PersonService personService) {
        return List.of(ToolCallbacks.from(personService));
    }

    @Bean
    public ToolCallback directoryListToolCallback(DirectoryListToolFunction function) {
        return FunctionToolCallback.builder("directory_list", function)
                .description("列出指定目录的文件列表")
                .inputType(DirectoryListToolFunction.Request.class).build();
    }

    @Bean
    public ToolCallback weatherQueryToolCallback(WeatherQueryToolFunction function) {
        return FunctionToolCallback.builder("weather_query", function)
                .description("查询指定城市的天气信息")
                .inputType(WeatherQueryToolFunction.Request.class).build();
    }

    @Bean
    public ToolCallback userProfileQueryToolCallback(UserProfileQueryToolFunction function) {
        return FunctionToolCallback.builder("user_profile_query", function)
                .description("用户信息查询")
                .inputType(UserProfileQueryToolFunction.Request.class).build();
    }

}
