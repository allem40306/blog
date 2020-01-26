---
title: Hexo教學2 iframe(likecoin)
category: Hexo
tags:
  - Hexo
  - likecoin
abbrlink: 183a
date: 2020-01-25 20:51:01
---
前幾天在把 likecoin 的外掛加入 blog 裡面。
<!-- more -->
問我同學後，他告訴我要用 `iframe` 這個[標籤外掛](https://hexo.io/zh-tw/docs/tag-plugins.html)，以 theme cafe 為例，加入在 `layout/_partial/article.ejs` 裡，把 `{your_id}` 換成你在 likecoin 的 ID 就行：

```
<div>
    <hr>
    <p style="margin-bottom: 0;">如果你覺得這篇文章很棒，請你不吝點讚 (ﾟ∀ﾟ)</p>
    <iframe width="100%" height="230px" scrolling="no" frameborder="0" id="player" src="https://button.like.co/in/embed/{your_id}/button/?referrer=<%- post.permalink %>" allowfullscreen="true"></iframe>
</div>
```

iframe 等標籤外掛是用來補 markdown 的不足，而 iframe 用來崁入外部資源時非常好用。

更多 Hexo 的標籤外掛：https://hexo.io/zh-tw/docs/tag-plugins.html