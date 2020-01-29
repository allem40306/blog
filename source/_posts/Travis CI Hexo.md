---
title: Travis CI Hexo
abbrlink: '9365'
date: 2020-01-29 14:47:44
category: Travis CI
tags:
  - Travis CI
  - Hexo
---
今天我把 hexo 更新也用 Travis CI 來自動化了。
<!-- more -->
先來放我的 `.travis.yml`

```yml
language: node_js
node_js:
  - "10"

cache:
  directories:
    - node_modules

install:
  - npm install hexo-cli -g
  - npm install

script:
  - hexo g

deploy:
  provider: pages
  skip-cleanup: true
  github-token: $GITHUB_TOKEN
  local-dir: public
  keep-history: false
  on:
    branch: hexo
```

以下是一些設定的詳細資訊
* `nodejs`
    * 原本是設定 `LTS`，後來發現這樣 theme cafe 提供的 Recommended Posts 會壞掉，所以設定版本為 `10`
* `install`
    * 依照 `package.json` + `hexo-cli` 安裝所需套件，
* `script` 
    * 就只要 `hexo g` (`hexo generate`) 一條指令就可以
* `deploy`
    * `provider: pages`：設定這一行 `Travis CI` 會幫我們自動 push 到 `gh-pages` 上
    * `github-token`：照樣要先在 github 產生一組 token 來驗證 push
    * `local-dir`：要 push 的只有 `hxo g` 所產生的 `public` 資料夾

這就是我的設定及說明，更多的可以參考我之前的文章[Travis CI 初次OK](../ce5f)。