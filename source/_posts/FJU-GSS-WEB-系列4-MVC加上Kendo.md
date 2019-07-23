---
title: FJU GSS WEB 系列4 MVC加上Kendo
date: 2019-07-22 14:45:33
category: FJU GSS Web
tags:
- FJU GSS Web
- Frontend
- Kendo
- MVC
---
經過第三堂課的摧殘(X)磨練(O)之後，最後我們將MVC原本的`@`(例如htmlhelper或viewbag)改成Kendo，並加上一些功能，就等同於將前面的課做個整合，一開始不知道怎麼改，後來知道是知道關鍵是"JSON"，後端算出的資料用JSON回傳到前端，前端再去就分析JSON檔，了解了之後，在AJAX又吃到幾個bug：
* 第一個是發現ajax沒有進到應該進入的函式，經過一番研究之後，發現是傳入SQL的參數有`<br>`的字串，這個問題不是AJAX所引起的，但是有用到AJAX，debug會比較困難
* 第二個是使用AJAX後，發現有些資料沒讀到AJAX更新後的資料，這個問題是關於AJAX的特性了，因為AJAX會跟之後的程式碼"同時"執行，所以如果要讀取更新後的資料，就要放在AJAX的`success`之後

處理完AJAX大概就能把Code Review要呈現的部分弄好了，剩下排版部分，也因為開始忙去台南比賽的事，要沒什麼動了。
(關於台南的事情，請關注下一系列文章!!!)
從台南回來很晚了，所以周五就晚點去WEB營隊，去的時侯也準備也吃午餐，所以也沒捨麼再改程式，就準備簡報和做別的事了。這次的Code Review是由營隊主要負責人Kenny親自來，好幾個重點我都懂，但實際寫Code就會踩到這個地雷：
* 要把判斷寫在後端，在前端就會被駭
* 有些都是是類似的程式碼，可以寫成一個function
* 用Kendo的東西就用kendo取值
* sql用like比較慢

Code Review完，每個人還要報告一份AAR(After Action Report)，這就留給下一篇講