---
title: npx 介紹
abbrlink: 57fe
date: 2021-07-18 23:15:34
category: 隨筆
tags:
- Nodejs
- Npx
---
npx 是 npm 在版本 5.2.0 之後的指令，最主要的功用在於 package 可以在不安裝在本地的情況下被執行，這樣避免了本地環境被汙染。例如我們要建立一個 react 的 app：

```
npx npx create-react-app my-app
```

npx 可以指定 package 的版本，也可以執行 github 的 gist 或 repo。

參考：
* https://medium.com/itsems-frontend/whats-npx-e83400efe7f8
* https://www.ruanyifeng.com/blog/2019/02/npx.html
* https://medium.com/@elijahmanor/learn-about-the-npx-package-runner-769f6e0bc404