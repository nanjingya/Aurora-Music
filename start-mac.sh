#!/bin/bash
# Aurora Music macOS 一键启动脚本
# 用法：bash start-mac.sh
#
# 说明：
# 1) Cursor / VSCode 终端会注入 ELECTRON_RUN_AS_NODE=1，导致 Electron
#    退化成纯 Node 运行、require('electron') 失效 —— 本脚本会清掉它。
# 2) Cursor 终端在命令结束后会回收子进程组，普通后台启动会被杀。
#    因此通过 macOS `open`（launchd）启动，让应用完全脱离终端独立运行。

cd "$(dirname "$0")"

unset ELECTRON_RUN_AS_NODE
unset ELECTRON_NO_ATTACH_CONSOLE

APP="node_modules/electron/dist/Electron.app"
ELECTRON="$APP/Contents/MacOS/Electron"

if [ ! -f "$ELECTRON" ]; then
  echo "[start-mac] 正在下载 Electron 二进制文件..."
  node node_modules/electron/install.js
fi

# 首次使用：移除隔离标记 + ad-hoc 签名（无需开发者账号）
xattr -rd com.apple.quarantine "$APP" 2>/dev/null || true
codesign --sign - --force --deep "$APP" 2>/dev/null || true

echo "[start-mac] 启动 Aurora Music..."

# 优先用 open（launchd）启动，彻底脱离 Cursor 终端进程组，避免被回收
if command -v open >/dev/null 2>&1; then
  open -n "$APP" --args "$(pwd)"
else
  exec "$ELECTRON" .
fi
