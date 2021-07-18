---
title: nvm 介紹
abbrlink: c414
date: 2021-07-18 23:13:55
category: 隨筆
tags:
- Nodejs
- Nvm
---
我在一台 server 上安裝 nodejs,為了避免和其他人安裝的版本衝突，我改安裝 nvm，安裝指令如下：
<!-- more -->
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

或

```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

安裝完成，本機的 profile 會增加以下字句：

```
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

輸入 `command -v nvm` 判斷是否安裝完成。

以下為基本指令：

```
nvm install <version> # 安裝特定版本
nvm uninstall <version> # 解除安裝特定版本
nvm use <version> # 使用特定版本
nvm ls # 列出畚箕已安裝的版本
nvm ls-remote # 列出遠端所有可用的版本
nvm --version # 查看 nvm 版本
nvm alias <name> <version> # 將版本取別名
nvm which <version> # 查看版本安裝路徑
```

參考：
* https://github.com/nvm-sh/nvm
* https://pjchender.dev/nodejs/nvm/
* https://titangene.github.io/article/nvm.html
