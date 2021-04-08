---
title: Python requirements.txt
abbrlink: '9787'
date: 2021-04-08 17:32:13
category: 隨筆
tags:
- Python
---
`requirements.txt` 是 Python 的 `pip` 管理套件的工具。當換到新環境開發時，可以快速架設環境。
<!-- more -->
導出環境
```
pip freeze > requirements.txt
```
導入環境
```
pip install -r requirements.txt
```

[這篇文章](http://pre.tir.tw/008/blog/output/pip-workflow-guan-li-requirementtxt.html)提到上述方法有不易升級和沒辦法看到專案所依賴的套件，因此可以分成兩個檔案，一個用來記錄基本要安裝的檔案，一個紀錄實際有安裝的檔案。	