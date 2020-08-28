---
title: Travis CI Mkdocs
abbrlink: 798e
date: 2020-08-28 11:39:39
category: Travis CI
tags:
- Travis CI
- Mkdocs
---
最近開始續寫校內程式競賽講義，為了方便維護，從原本的 `Tex` 轉到 `mkdocs`，也要用 Travis CI 進行部屬，才能讓其他人直接改內容，上傳後 CI 幫忙建置。
<!-- more -->
參考：https://www.coder.work/article/1251214

```yml
language: python # Set the build language to Python

python: 3.6 # Set the version of Python to use

branches: master # Set the branch to build from

install:
    - pip install -r requirements.txt # Install the required dependencies

script: true # Skip script (Don't use this if one already exists)

before_deploy:
    - mkdocs build --verbose --clean # Build a local version of the docs

deploy: # Deploy documentation to Github in the gh_pages branch
    provider: pages
    cleanup: true
    dir: site
    token: $GITHUB_TOKEN
    on:
        branch: master
```

`install` 要安裝的要件我都放在 `requirements.txt` 裡，這樣如果要多安裝其他東西就可以直接修改 `requirements.txt`。`before_deploy` 中，`mkdocs` 我加了 `--verbose` 指令，如果有錯可以直接看。

這次是 organization 的專案，花了一些時間在摸索，後來發現只差再需要 organization 的授權，其餘步驟都是相同的。