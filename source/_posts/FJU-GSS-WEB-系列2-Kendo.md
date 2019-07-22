---
title: FJU GSS WEB 系列2 Kendo
date: 2019-07-21 16:22:01
category: FJU GSS Web
tags:
- FJU GSS Web
- Frontend
- Kendo
---
第二堂課的主題是前端，主要的是學習一套UI名為Kendo，學了之後覺得不錯，原本還想要把他拿去用在OJ上，但聽到這個是要付費的即作罷。
Code Review的考題是要將一個網站的各種功能用Kendo實現出來，能看API做出來是很重要的一環，不過更重要的是使用者體驗和用資料傳輸這兩部分：
* Event.preventDefault()可以取消預設行為，所以在按summit button之後，網頁不會重整，進而達到更加的使用者體驗
* 要更新Kendo Grid的內容，呼叫`dataSource.read()`就可以，不用更新整頁面
* debugger是好用東西(之後再寫一篇文章做介紹)

這堂課就寫這邊了，寫完之後發現收穫的東西不多，可能是因為我都有在接觸前端的關係，看看下一篇心得會不會比較多。