---
title: GNU Privacy Guard 用於 git commit
abbrlink: 711e
date: 2021-05-01 07:23:38
category: 隨筆
tags:
---
Commit 一邊來說會設定 username 和 email 用來辨識貢獻者，但是只要知道任何人的 Commit 是可以偽造的。
<!-- more -->
GNU Privacy Guard 可用來做數位簽章，首先要安裝。Windows 要到官網下載安裝後設定路徑，類 Unix 的則利用套件安裝，安裝完成後，輸入 `gpg --version`，如果跑出版本資訊就代表成功了。

![](https://i.imgur.com/fJXijLv.png)

輸入 `gpg --generate-key` 會要求輸入 username 和 email，不一定要和 Github 一樣(我本人覺得還是一樣會比較好)，接著的步驟就一直按 `Enter` 就好了。

輸入 `gpg --list-keys` 查詢自己的 `key ID` (B67..CC0)。

![](https://i.imgur.com/ffRcVRb.png)

輸入 `gpg --armor --export <KEY_ID>` 得出公鑰。將公鑰放到 `Github > Personal Setting > SHH and RPG keys` 裡。

設定本地端 git。
```
git config --global commit.gpgsign true
git config --global user.signingkey <KEY_ID>
```

這樣就大功告成，之後 Github 的 commit 紀錄都會顯示 `Verified` 的狀態。

![](https://i.imgur.com/Qc6zUQF.png)

參考與延伸閱讀
：
https://medium.com/starbugs/how-to-fake-the-author-of-git-commit-f44453b70afc
http://pre.tir.tw/008/blog/output/gnupg-gpg-jin-yao-guan-li.html
https://blog.miniasp.com/post/2020/05/04/How-to-use-GPG-sign-git-commit-and-tag-object