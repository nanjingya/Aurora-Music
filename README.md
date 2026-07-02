# Aurora Music

![Aurora Music](./assets/aurora-music-hero.png)

桌面 / Dock 应用图标：

![Aurora Music Icon](./assets/aurora-music-icon-256.png)

> **极光 · 沉浸式音乐播放器**  
> **作者：nanjingya**  
> **版本：v1.2.0**  
> **平台：macOS（Apple Silicon arm64 / Intel x64）**

Aurora Music 是一款沉浸式桌面音乐播放器，基于 Electron + Node.js 构建，整合搜索播放、歌词舞台、粒子视觉、3D 歌单架、天气电台与 DIY 视觉控制台。

---

## Homebrew 安装（推荐）

### 个人 Tap（已可用）

```bash
brew tap nanjingya/tap
brew trust nanjingya/tap
brew install --cask aurora-music
```

- Apple Silicon 自动安装 **arm64** 包，Intel Mac 自动安装 **x64** 包
- Tap 仓库：[nanjingya/homebrew-tap](https://github.com/nanjingya/homebrew-tap)

### 官方 Homebrew Cask（审核中）

已向官方仓库提交 PR，合并后可直接：

```bash
brew install --cask aurora-music
```

- PR：[Homebrew/homebrew-cask#272754](https://github.com/Homebrew/homebrew-cask/pull/272754)

### 升级

```bash
brew update
brew upgrade --cask aurora-music
```

---

## 安装包下载

从 [GitHub Releases](https://github.com/nanjingya/Aurora-Music/releases) 下载对应架构的 DMG：

| 架构 | 文件名 | 适用 |
| --- | --- | --- |
| **Apple Silicon** | `Aurora-Music-1.2.0-mac-arm64.dmg` | M1 / M2 / M3 / M4 |
| **Intel** | `Aurora-Music-1.2.0-mac-x64.dmg` | Intel Mac |

**v1.2.0 SHA256**

```
Aurora-Music-1.2.0-mac-arm64.dmg  b36b55e8cfbdbf3b99f29becbafa39574606d736e15dc821142e88e680444874
Aurora-Music-1.2.0-mac-x64.dmg    f6c9248c49ce1c2d6d03cbb0f15d0e331beb3b74d13f76d88d83d66c61d1956d
```

> **M 系列 Mac 请安装 arm64 包**，不要装 x64 版（Rosetta 转译会明显卡顿）。

### 安装步骤

1. 双击打开对应架构的 DMG
2. 将 **Aurora Music** 拖入 **Applications（应用程序）** 文件夹
3. 首次打开若提示「无法验证开发者」，请执行：

```bash
xattr -rd com.apple.quarantine "/Applications/Aurora Music.app"
```

或在 **系统设置 → 隐私与安全性** 中点击 **仍要打开**。

4. 启动后 Dock 显示 **Aurora Music**，窗口加载 `http://127.0.0.1:3000/`

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
npm run build:mac
shasum -a 256 dist/Aurora-Music-1.2.0-mac-*.dmg
```

产物：

- `dist/Aurora-Music-1.2.0-mac-arm64.dmg`
- `dist/Aurora-Music-1.2.0-mac-x64.dmg`

---

## 常见问题

### 启动报错 / 闪退（源码模式）

使用 `bash start-mac.sh`，不要在 Cursor 终端直接 `npm start`。

### 安装包被 Gatekeeper 拦截

```bash
xattr -rd com.apple.quarantine "/Applications/Aurora Music.app"
```

### 安装版很卡 / 没有源码版流畅

- **M 系列 Mac 必须装 arm64 包**，x64 包走 Rosetta 会明显卡顿
- 安装后执行去隔离：`xattr -rd com.apple.quarantine "/Applications/Aurora Music.app"`

### 每日推荐点击无反应

确认网易云已登录；v1.2.0 已修复首页空白点击误拦截问题。部分 VIP 歌曲仅可试听。

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

*作者：nanjingya · 更新时间：2026-07-02*
