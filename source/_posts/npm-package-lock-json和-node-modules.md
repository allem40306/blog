---
title: npm package.lock.json和 node_modules
category: Web
tags:
  - npm
abbrlink: '2613'
date: 2019-08-29 17:23:03
---
前段時間學到有關於npm初始化的一些東西。
<!-- more -->
`package.json`紀錄npm所要安裝的檔案，這時`node_modules/`和`package-lock.json`就會生出來，不同OS會有不同的結果，所以這兩個要放`.gitignore`裡。
`package-lock.json`主要在解決packages之間的相依性，更多的介紹可以參考https://docs.npmjs.com/files/package-lock.json。
