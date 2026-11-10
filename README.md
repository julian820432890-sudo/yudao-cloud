# 安天智能物流 · 系统管理版

当前分支：`master-jdk17-base-system`，从 `master-jdk17-base` 分出。

## 保留范围

- `antian-module-system`：租户、用户、角色、菜单、部门、岗位、字典、通知、审计日志、OAuth2、社交登录及管理概览。
- `antian-gateway`：仅转发系统管理、系统文件上传和实时通知连接。
- `antian-framework`、`antian-dependencies`：公共组件和统一依赖。
- 文件、参数配置、API 日志及消息发送的必要实现内嵌在系统模块中，兼容原文件配置包名和接口路径，不再启动独立的 infra 服务。

其他业务模块及页面已在此分支移除。原完整分支保留，现有数据库表和授权记录不删除。

## 本地启动

1. 使用 JDK 17 或 21、Maven 3.9，先启动 MySQL、Redis、Nacos（`dev` 命名空间）。
2. 本地数据库连接见系统模块的 `application-local.yaml`；现有 `ruoyi-vue-pro` 可直接继续使用。
3. 仅为新建空数据库初始化时使用 `sql/mysql/init-system.sql`，现有数据库不要重新导入。
4. 在项目根目录执行 `mvn clean package -DskipTests`。
5. IntelliJ IDEA 重新加载 Maven 项目后，运行 `Local System` 和 `Local Gateway`，或使用 `Antian Local` 组合配置。
6. 系统服务端口 `48081`，网关端口 `48080`；服务只在本机监听的参数保留在 IDEA 本地运行配置中。
7. 前端使用 `master-base-system` 分支，在其目录执行 `pnpm install`、`pnpm dev`，访问 `http://localhost`。

也可运行打包后的两个 Jar；启动时附加 `--server.address=127.0.0.1 --spring.cloud.nacos.discovery.ip=127.0.0.1` 用于本机开发。

本分支从仓库内配置启动，不加载共享 Nacos 业务配置，避免完整版本的路由覆盖精简配置；服务发现仍使用 Nacos。
文件读取公开地址默认经网关 `http://127.0.0.1:48080`，可用 `ANTIAN_FILE_PUBLIC_URL` 环境变量覆盖。

## 登录与权限

现有租户、账号及角色直接保留。`superAdmin` 的系统管理菜单和租户查询、新增、编辑、导出、删除权限保留；普通租户仍隔离，内置系统租户仍受保护。第三方授权登录需要原企业的有效配置。
