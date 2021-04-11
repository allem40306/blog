---
title: UVa10859 Placing Lampposts
abbrlink: 9b4d
date: 2020-07-23 22:45:18
category: UVa
tags:
  - UVa
  - Graph
  - DP
  - 樹形 DP
  - 程式競賽選修課
  - 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=onlinejudge&Itemid=8&page=show_problem&problem=1800)
* 題意：給定一個由多個樹狀道路形成的國家，要在放最少盞燈，使得每條路至少被一盞燈照到，如果有多組符合，讓被兩盞燈照到的路越多越好。
<!-- more -->
* 題解：這題是最小點覆蓋，但同時要考慮最大化被兩盞燈照到的路數量，可以轉乘慮最小化只被一盞燈照到的路數量，另 $X=MX_1+X_2$，$X_1=$燈的數量，$X_2=$被一盞燈照到的路數量，$M$ 為一個很大的數(大於總點數就可以)，這樣保證 $X_1$ 比較小的方法，$X$ 也一定也比較少。這題轉成利用樹形 DP 來最小化 $X$。每當開一盞燈 $X+=M$，每新增一條只有被一盞燈照到的路 $X+=1$。

```cpp=
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int M = 2e3;
const int MXV = 1e3 + 5;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
vector<int> G[MXV];
int dp[MXV][2];
bitset<MXV> vis;

void init(int n, int m)
{
    FOR(i, 0, n + 1) { G[i].clear(); }
    FOR(i, 0, m)
    {
        int x, y;
        cin >> x >> y;
        G[x].push_back(y);
        G[y].push_back(x);
    }
    vis.reset();
}

void dfs(int u)
{
    vis[u] = true;
    dp[u][0] = 0;
    dp[u][1] = M;

    for(int v: G[u])
    {
        if(vis[v])
        {
            continue;
        }
        dfs(v);
        dp[u][0] += dp[v][1] + 1;
        if(dp[v][0] < dp[v][1])
        {
            dp[u][1] += dp[v][0] + 1;
        }
        else
        {
            dp[u][1] += dp[v][1];
        }
    }

    return ;
}

int main()
{
    IOS;
    int t, n, m;
    cin >> t;
    while (t--)
    {
        cin >> n >> m;
        init(n, m);
        int ans = 0;
        FOR(i,0,n)
        {
            if(!vis[i])
            {
                dfs(i);
                ans += min(dp[i][0], dp[i][1]);
            }
        }
        cout << ans / M << ' ' << m - ans % M << ' ' << ans % M << '\n';
    }
}
```