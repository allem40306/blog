---
title: 手動安裝 latex package
abbrlink: 8fdd
date: 2021-05-09 23:03:51
category: 隨筆
tags:
- Latex
---
有時候，latex 無法奔我們自動安裝 package，我們可以自行手動安裝。
<!-- more -->
先到 https://ctan.org 下載壓縮檔。

解壓縮後，到資料夾裡面執行指令 `latex <packagename>.ins`，會生成 `<packagename>.sty`。

接著把整個資料夾搬移到存放 package 的資料夾下，`linux` 和 `windows` 系統操作上有些不同，可以參考下列文章：

https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows
https://jvgomez.github.io/pages/manually-install-latex-packages-in-ubuntu.html