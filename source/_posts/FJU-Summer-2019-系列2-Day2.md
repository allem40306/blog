---
title: FJU Summer 2019 系列2 Day2
category: 輔大
tags:
  - FJU Summer 2019
abbrlink: e828
date: 2019-09-15 11:45:12
---
第二天打的比賽是NPSC2010國中組決賽([連結](http://contest.cc.ntu.edu.tw/npsc2010/schedule.asp))，看到不是高中組決賽就放心了。
<!-- more -->
* PA 帕斯卡三角形
題目：求帕斯卡三角形第M列第N項
解法：DP

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 20;
int dp[MXN][MXN];
 
int main(){
    dp[0][0] = 1;
    for(int i = 1; i <= 13; ++i)
    {
        for(int j = 1; j <= i; ++j)
        {
            dp[i][j] += dp[i - 1][j] + dp[i - 1][j - 1];
        }
    }
    int t, n, m;
    cin >> t;
    while(t--)
    {
        cin >> n >> m;
        cout << dp[n][m] << '\n';
    }
}
{% endcodeblock %}

* PB 好吃的麵包
題目：給定$M, N$，要解出$x+y=M$, $20x+12y=N$中的$x, y$
解法：用克拉瑪解出

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int t, x, y, n, m;
    cin >> t;
    while (t--)
    {
        /*
        1 1 m
        x y n
        */
        cin >> n >> x >> y >> m;
        int dx = m * y - n;
        int dy = n - x * m;
        int d = y - x;
        cout << (dx / d) << ' ' << (dy / d) << '\n';
    }
}
{% endcodeblock %}

* PC 魔法氣泡
題目：給定$H \times W$的表格，求出用$C$種顏色填滿格子，且相鄰(上下左右)格子不能同顏色的方法數。
解法：輪廓線DP

* PA 三生萬物
題目：給定一個長度$N(N\leq 500)$的數列，只包含$-3, -2, -1, 0, 1, 2, 3$七種數字，問有沒有一種順序使得前$i(1 \leq i \leq N)$項總和都介於$0$到$3$之間。
解法：Ad-Hoc題，想辦法壓複雜度(?)

* PE 得分
題目：有$N$種得分方式，問有幾種方法可以剛好得$S$分
解法：無限背包

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
const int MXN = 10005;
 
int main()
{
    int t, n, s;
    LL dp[MXN];
    cin >> t;
    while(t--)
    {
        cin >> n >> s;
        memset(dp, 0, sizeof(dp));
        dp[0] = 1;
        for(int i = 0, x; i != n; ++i)
        {
            cin >> x;
            for(int j = x; j <= s; ++j)
            {
                dp[j] = dp[j] + dp[j - x];
            }
        }
        cout << dp[s] << '\n';
    }
}
{% endcodeblock %}

* PF 一棵開花的樹
題目：給你一顆樹，如果花染紅，從花到根的路徑都會染紅，染紅$K$朵花後，問整棵樹有多少地方染紅
解法：一題題敘很難懂的題目，讀完題目用`vector`存樹後，老實地做就過了

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 50005;
int main()
{
    int t, n, m, k;
    vector<int> tree[MXN], f, par;
    bitset<MXN> vis;
    cin >> t;
    while(t--)
    {
        cin >> n >> m >> k;
        par.resize(n + 5);
        par[1] = 1;
        for(int i = 1, m, x; i <= n; ++i)
        {
            tree[i].clear();
            cin >> m;
            while(m--)
            {
                cin >> x;
                tree[i].push_back(x);
                par[x] = i;
            }
        }
        f.resize(m + 5);
        for(int i = 1, x, a; i <= m; ++i)
        {
            f[i] = 1;
            cin >> x;
            while(x--)
            {
                cin >> a;
                f[i] = tree[f[i]][a - 1];
            }
        }
        int ans = 0;
        vis.reset();
        for(int i = 0, x; i != k; ++i)
        {
            cin >> x;
            x = f[x];
            while(!vis[x])
            {
                ++ans;
                vis[x] = 1;
                x = par[x];
            }
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PG 失落的維京戰機
題目：給定只有`+`和`*`的運算式，求出結果
解法：將式子轉為後序後計算

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int t;
    string s;
    cin >> t;
    while(t--)
    {
        queue<char> q;
        stack<char> ops;
        cin >> s;
        for(int i = 0; i != (int)s.size(); ++i)
        {
            if(isalnum(s[i]))
            {
                q.push(s[i]);
            }
            else
            { 
                if(s[i] == '+')
                {
                    while(!ops.empty())
                    {
                        q.push(ops.top());
                        ops.pop();
                    }
                }
                ops.push(s[i]);
            }
             
        }
        while(!ops.empty())
        {
            q.push(ops.top());
            ops.pop();
        }
        stack<int> st;
        while(!q.empty())
        {
            char ch = q.front(); q.pop();
            if(isalnum(ch))
            {
                st.push((int)(ch - '0'));
            }
            else
            {
                int rhs = st.top(); st.pop();
                int lhs = st.top(); st.pop();
                if(ch == '+')
                {
                    lhs += rhs;
                }
                else
                {
                    lhs *= rhs;
                }
                st.push(lhs);                
            } 
        }
        cout << st.top() << '\n';
    }
}
{% endcodeblock %}

這場比賽大概就這樣，算中等偏易。

晚上就在講DP，這堂課我聽得似懂非懂，一方面是我一開始就沒有打算要認真聽，一方面是這個講師我不適應他的講課模式，不過他講的內容算是滿實用的。