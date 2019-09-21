---
title: Travis CI 初次OK
date: 2019-09-02 21:02:02
category: Travis CI
tags:
- Travis CI
---
之前有提過我在codebook上用Travis CI，後來發現是在token上沒設定好，然後部署的結果是在github的release上面。

現在就來介紹一下Travis CI，CI(Continuous Intergration)是在軟體開發上一個機制，會根據程式碼的更動，自動建置(build)、測試(test)、驗證，如果驗證成功才會發佈/部署，這樣可以保證上線的產品的品質。而Travis CI是在github上面的CI整合工具。以下為使用Travis步驟：

* 先到[Travis CI網站](https://travis-ci.org)，用github註冊
* 選擇要應用的專案
* 在專案加入`.travis.yml`，設定運行流程
* 最後push在github上，再到Travis CI網站看結果就可以了

現在就來說明`.travis.yml`常見配置項：

* `language`：設定語言，在[Travis CI文件](https://docs.travis-ci.com)可以查到支持的語言，如果沒有你要的話，就設為`generic`
* `install`：安裝Dependency
* `script`：執行腳本

install和script是兩個CI的主要階端，然而可以添加不同階段的指令：

* `before_install`
* `before_script`
* `after_failure`
* `after_success`
* `before_deploy`
* `after_deploy`
* `after_script`

我當初不知道`before_install`, `before_script`的作用為何，於是[查到這篇](https://stackoverflow.com/questions/34377017/what-are-the-differences-between-the-before-install-script-travis-yml-opti)，如果有人不清楚也可以參考。

第一次寫Travis CI文章有些生疏，還請各位指教，之後我有能力會再寫這系列的文章，或是分享我的設定。