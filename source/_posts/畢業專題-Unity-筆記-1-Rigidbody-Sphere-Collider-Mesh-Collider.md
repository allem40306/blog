---
title: '畢業專題 Unity 筆記 1 Rigidbody, Sphere Collider, Mesh Collider'
abbrlink: 191a
date: 2020-07-20 21:14:32
category: 隨筆
tags:
- Project 畢業專題
- Unity
---
最近開始用 Unity 建 VR ，為了以後可以快速檢視，所以來寫筆記。
<!-- more -->
Rigibody 可以給與物件物理效果，例如碰撞。我用 Rigidbody 是要賦予物品重力，用來解決物品沒辦法好好的落在地面上的問題。但只有 Rigidbody 物品會穿過地板，必須在物品加上 Sphere Collider，地板加上 Mesh Collider 才行。

第二個問題是當裝上這些東西，物品會彈開，並且會在半空中旋轉著，旋轉的問題我用 Rigidbody 下的 Freeze Rotation 的選項解決，彈開的問題是我發現有些物品的 Sphere Collider 的 Radius 過大，將它調在適當大小就可以了，調這個花費我一些心思，調太大會讓物品旋在半空，太小會讓物品穿越地板，目前做的區域，剩一些比較小的東西需要調整，其餘都處理好了，接下來應該要測試看看才知道哪些還要調整。