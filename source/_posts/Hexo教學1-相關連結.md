---
title: Hexo教學1 相關連結
date: 2019-07-23 09:27:27
category: Hexo
tags:
- Hexo
---
前幾天我突然想要在blog的邊欄(Sidebar)增加一個連結，這樣我的粉絲團的能見度會提升，於是我爬文，找到了解答，大概步驟如下：
* 在`/source`增加`_data`資料夾，並在資料夾裡面新增`links.yml`，完整路徑為`/source/_data/links.yml`，該文件內容如下
{% codeblock lang:yml %}
FB粉專: https://www.facebook.com/allem40306codeblog/
{% endcodeblock %}

* 接著改變theme的layout設定，在`themes\{your_theme}\layout\_widget`新增`links.ejs`，根據不同theme寫法會有些不同(主要是CSS套用)，這份code裡面的`site.data.links`對應到`links.yml`
{% codeblock lang:html %}
<% if (site.data.links){ %>
  <div class="widget-wrap">
    <h3 class="widget-title">相關連結</h3>
    <div class="widget">
      <% for (var i in site.data.links){ %>
        <li class='link'><a href='<%- site.data.links[i] %>'><%= i %></a></li>
      <% } %>
    </div>
  </div>
<% } %>
{% endcodeblock %}

* 最後在`themes\{your_theme}\_config.yml`中的`widget`新增`links`項目就完成了

參考文章：https://www.jianshu.com/p/43eb0819f51a