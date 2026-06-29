# Aurora Music

![Aurora Music](./assets/aurora-music-hero.png)

桌面 / Dock 应用图标：

![Aurora Music Icon](./assets/aurora-music-icon-256.png)

> **极光 · 沉浸式音乐播放器**  
> **作者：nanjingya**  
> **版本：v1.1.1**  
> **平台：macOS（Apple Silicon / arm64）**

Aurora Music 是一款沉浸式桌面音乐播放器，基于 Electron + Node.js 构建，整合搜索播放、歌词舞台、粒子视觉、3D 歌单架、天气电台与 DIY 视觉控制台。

---

## 安装包下载

| 项目 | 说明 |
| --- | --- |
| **文件名** | `Aurora-Music-1.1.1-mac-arm64.dmg` |
| **路径** | [GitHub Releases](https://github.com/nanjingya/Aurora-Music/releases) 下载 `Aurora-Music-1.1.1-mac-arm64.dmg` |
| **大小** | 约 132 MB |
| **架构** | Apple Silicon（M1 / M2 / M3 / M4 等 arm64 芯片） |
| **SHA256** | `164fb39ddea663f75eb1165154820d87a843dd0a6a3b4d919082dac0659560c5` |

### 安装步骤

1. 先打包生成安装包（见下方「重新打包」）
2. 双击打开 `dist/Aurora-Music-1.1.1-mac-arm64.dmg`
3. 将 **Aurora Music** 拖入 **Applications（应用程序）** 文件夹
4. 首次打开若提示「无法验证开发者」，请执行：

```bash
xattr -rd com.apple.quarantine "/Applications/Aurora Music.app"
```

或在 **系统设置 → 隐私与安全性** 中点击 **仍要打开**。

5. 启动后 Dock 显示 **Aurora Music**，窗口加载 `http://127.0.0.1:3000/`

> **Intel Mac 用户**：当前包为 arm64。若需 Intel 版，在源码目录执行 `npx electron-builder --mac dmg --x64`。

---

## 核心功能

| 模块 | 说明 |
| --- | --- |
| **音乐源** | 网易云音乐 + QQ 音乐 |
| **首页 Home** | 账号卡片、网易云每日推荐、天气电台、私人电台、继续听 |
| **播放体验** | 队列管理、音质选择、播放/暂停淡入淡出 |
| **视觉系统** | Wallpaper 银河首页、Emily 播放态视觉、粒子预设 |
| **歌词** | 歌词舞台、自定义歌词 |
| **3D 歌单架** | 右键唤起，浏览歌单与队列 |
| **桌面壳** | 自定义标题栏、全屏/最大化、单实例 |

---

## 技术架构

```text
Aurora Music/
├── desktop/              # Electron 主进程 / preload
├── public/index.html     # 主 UI + 视觉系统
├── server.js             # 本地 HTTP API
├── start-mac.sh          # macOS 推荐启动脚本
├── dist/                 # DMG 安装包
└── package.json
```

### 本地数据目录（macOS）

| 类型 | 路径 |
| --- | --- |
| **节拍分析缓存** | `~/Library/Application Support/Aurora Music/beatmaps/` |
| **登录 Cookie** | 应用数据目录（Electron partition） |
| **用户存档 / 设置** | 浏览器 localStorage（应用内） |

> 项目根目录下 **不存在** 也不应提交 `D:\MineradioCache\beatmaps`。那是 Windows 版遗留路径，在 Mac 上会被误创建为奇怪文件夹名；已删除，并改为上述 macOS 标准路径。

---

## 源码启动（开发）

### 推荐：`start-mac.sh`

```bash
cd /path/to/Mineradio
npm install
bash start-mac.sh
```

Cursor / VSCode 终端会注入 `ELECTRON_RUN_AS_NODE=1` 导致 Electron 无法启动；本脚本会清除该变量并通过 `open -n` 独立启动。

### 备选：`npm run start:mac`

```bash
npm run start:mac
```

### 停止应用

```bash
pkill -f "Aurora Music.app"
```

---

## 重新打包

```bash
npm install
npx electron-builder --mac dmg --arm64
shasum -a 256 dist/Aurora-Music-1.1.1-mac-arm64.dmg
```

产物：`dist/Aurora-Music-1.1.1-mac-arm64.dmg`

---

## 常见问题

### 启动报错 / 闪退（源码模式）

使用 `bash start-mac.sh`，不要在 Cursor 终端直接 `npm start`。

### 安装包被 Gatekeeper 拦截

```bash
xattr -rd com.apple.quarantine "/Applications/Aurora Music.app"
```

### 每日推荐点击无声音

确认网易云已登录；部分歌曲有版权/VIP 限制。

### 歌单面板位置

macOS 版歌单面板在**屏幕左侧**；底栏歌单按钮或左边缘箭头可显隐。

---

## 命令速查

```bash
npm install
bash start-mac.sh
node --check server.js
npx electron-builder --mac dmg --arm64
```

---

## 声明

Aurora Music 不是网易云音乐、QQ 音乐或腾讯音乐娱乐集团的官方客户端。请遵守对应平台用户协议与版权规则。

---

*作者：nanjingya · 更新时间：2026-06-29*
