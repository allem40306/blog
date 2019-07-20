---
title: FJU GSS Web 系列1 SQL
date: 2019-07-20 12:24:02
category: FJU GSS Web
tags:
- FJU GSS Web
- SQL
---
首先課程是SQL，相關語法我之前已經學過一些基礎的語法，進階一點的語法，例如join和Subquerie，我多花了一點時間在這些地方。
課程有：
* SQL Server Management Studio(SSMS)的用法
* SELCET, ORDER, GROUP
* JOIN
* Subqueries
* Table Expressions(Views, Inline Table-Valued Functions(TVFs), Using Derived Tables(衍生資料表), Common Table Expressions(CTE))
* SET
* Window Ranking, Offset & Aggregate Functions
* PIVOT
* Stored Procedures
* Transactions with Insert, Delete, Update

這次workshop算容易的，主要是要用select和join的語法，後面幾題則是新增、刪除、更新的語法
每堂課最後都有code review，第一次是由助教來帶領我們進行，我是第一位，光是我就佔了40~50%左右的時間(之後每一次第一位都大概佔了一大部分比例)，當中學到了很多觀念，如下：
* 什麼時候要用inner join，什麼時候要用left(right) join
* 在select"前K名"類型的資料，如果有包含同名次的狀態要怎麼處理
* 在insert, delete, update要用"tran"包起來，避免有多筆請求同時對相同資料做變動時產生錯誤的結果

這次CodeReview最大收穫就是tran使用時機，以及身為開發者要跟系統分析師好好討論，彼此要互相cover，因為我們是人不是神，難免會犯錯。
