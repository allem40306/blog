---
title: remarkjs
abbrlink: 6f03
date: 2021-01-30 22:55:24
category: 隨筆
tags:
---
[remarkjs](https://remark.js.org/) 是用來當 Markdown 的解析器，可以用來檢查語法、生成 markdown 或 format 文件。
<!-- more -->
我在[訓練講義](https://fjuonlinejudge.github.io/Training) 當作，利用 remarkjs 來 fromat 所有 markdown 文件，remarkjs 有兩種使用方式，API 或 CLI，我用後者，首先在 `.remarkrc`，裡面包含設定和所需要的 plugins，再來要安裝 `remark-cli`
```
npm install remark-cli -g
```
就可以使用，以下指令會套用 `.remarkrc`的設定檔，來源是 `./docs` 的所有檔案，輸出同位置。
```
remark ./docs -o -r .remarkrc
```

參考連結：
remarkjs：https://github.com/remarkjs/remark
remarkjs 的 Plguin：(https://github.com/remarkjs/remark/blob/main/doc/plugins.md)
