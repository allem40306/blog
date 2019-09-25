---
title: FJU Summer 2019 系列3 Day3
category: 輔大
tags:
  - FJU Summer 2019
abbrlink: f9e8
date: 2019-09-15 12:29:08
---
這天打的是NPSC 2012國中組決賽。

* PA 烤餅乾
題目：問所有邊長為$M$的三角形有幾個
解法：枚舉+類似剪枝的技巧加速

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int t, m;
    cin >> t;
    while(t--)
    {
        cin >> m;
        int ans = 0;
        for(int i = 1; i <= m; ++i)
        {
            for(int j = i; i + j <= m; j++)
            {
                int k = m - i - j;
                if(k < j)
                {
                    break;
                }
                if(i + j > k)
                {
                    ++ans;
                }
            }
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PB 菇菇園
題目：有健康的和被寄生的菇菇，只要距離被寄生的菇菇$\leq K$就會被感染並傳染給其他菇菇，問最後有多少隻菇菇被寄生
解法：BFS/DFS

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 105;
using LL = long long;
struct Loc{
    LL x, y;
    LL dis(Loc rhs)
    {
        return (x - rhs.x) * (x - rhs.x) + (y - rhs.y) * (y - rhs.y);
    }
};
 
 
int main()
{
    cin.tie(nullptr);
    cout.tie(nullptr);
    ios_base::sync_with_stdio(false);
    int t, n, m;
    LL k;
    vector<Loc> locs;
    bitset<MXN> vis;
    queue<int> q;
    cin >> t;
    while(t--)
    {
        cin >> n >> m >> k;
        k *= k;
        locs.resize(n + 5);
        for(int i = 0; i < n; ++i)
        {
            cin >> locs[i].x >> locs[i].y;
        }
        vis.reset();
        for(int i = 0; i < m; ++i)
        {
            vis[i] = true;
            q.push(i);
        }
        int ans = 0;
        while(!q.empty())
        {
            ++ans;
            auto it = q.front(); q.pop();
            for(int i = m; i < n; ++i)
            {
                if(!vis[i] && locs[it].dis(locs[i]) <= k)
                {
                    vis[i] = true;
                    q.push(i);
                }
            }
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PC 蚯與地下城
題目：地下城有$N$個點和$M$條邊，編號越大越深，工蟻要從$1$號點走到$N$號點，但是它們遇到交叉入口，會選擇走編號小的那條路，問至少要堵住多少條通道才能讓公蟻們走到$N$號點。
解法：DP，維護在i號點最小要堵住多少路，由深(編號大)的點開始DP回到1號點。

* PD 蚯蚓王
題目：投票，問有沒有一個號碼超過投票人的$\frac{1}{2}$。
解法：用map維護每個號碼的票數，最後檢查有沒有票數超過$\frac{1}{2}$。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
 
int main()
{
    int t, n;
    int x;
    map<int, int>tb;
    cin >> t;
    while(t--)
    {
        tb.clear();
        cin >> n;
        for(int i = 0; i != n; ++i)
        {
            cin >> x;
            if(tb.find(x) == tb.end())
            {
                tb[x] = 1;
            }
            else
            {
                tb[x] += 1;
            }
        }
        int mx = 0, ans = 0;
        for(auto it: tb)
        {
            if(mx < it.second)
            {
                ans = it.first;
                mx = it.second;
            }
        }
        if(mx > n / 2)
        {
            cout << ans << '\n';
        }
        else
        {
            cout << -1 << '\n';
        }
         
    }
}
{% endcodeblock %}

* PE 黑與白
題目：每個人有自己想要穿的顏色，要把高的分一群，矮的分一群，兩群至少有一個人，問最多有幾個人可以穿自己想要的顏色。
解法：先用前綴和求出身高$\leq h$的人，兩種顏色分別有幾個人想要穿，再枚舉基準點(身高)算出最多穿自己想要的衣服顏色的人數。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 2005;
 
int main()
{
    int T, N, M, P;
    int x[MXN], y[MXN];
    vector<int> v;
    cin >> T;
    while(T--)
    {
        memset(x, 0, sizeof(x));
        memset(y, 0, sizeof(y));
        cin >> N;
        int cntx = 0, cnty = 0;
        for(int i = 0; i != N; ++i)
        {
            cin >> M >> P;
            if(!P)
            {
                ++x[M];
                ++cntx;
            }
            else
            {
                ++y[M];
                ++cnty;
            }
        }
        int ans = 0;
        for(int i = 1000; i <= 2000; ++i)
        {
            x[i] += x[i - 1];
            y[i] += y[i - 1];
        }
        for(int i = 1000; i <= 2000; ++i)
        {
            int ax = x[i] - x[999], ay = y[i] - y[999];
            int bx = x[2000] - x[i], by = y[2000] - y[i];
            if(ax + ay == 0 || bx + by == 0)
            {
                continue;
            }
            ans = max(ans, max(ax + by, ay + bx));
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PF 社群網路
題目：算出一張圖(數個連通塊)中，"三點兩兩相連"和"三點兩兩連通"的比例。
解法：直接做，簡單但是沒人解這題OAO。

* PG 蚯蚓的卡片
題目：把一段文字以螺旋方式輸出(題目比較清楚)，然後要小心不要印出最後的空白。
解法：沒什麼好說的，我當初WA在最後一行我把空白給印出來就WA了(我不知道他是多餘的)。

晚上就在上圖論了，講了最小生成樹、割邊割點、最短路這些我都聽過所以不覺得難，但有一部份再講一些進階的例題，我就完全離線了QQ。