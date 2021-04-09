---
title: POJ3321 Apple Tree
abbrlink: 25fc
date: 2020-08-21 17:03:40
category: POJ
tags:
- POJ
- Bit Index Tree
- 樹壓平
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://poj.org/problem?id=3321)
* 題意：給定一棵樹，一開始每個節點都有一棵蘋果，給定兩種操作，`C x` 改變節點 $x$ 有無蘋果存在的情況(有$\to$ 無，無$\to$ 有)，`Q x` 詢問以 $x$ 為根的子樹，有幾顆蘋果。
<!-- more -->
* 題解：一開始將樹壓平，以 $x$ 為根的子樹會在 $[L(x),R(x)]$ 內。接著利用 `樹狀數組(BIT)`，來維護區間和。對於操作 `C x`，將 $sum[L(x)]$ 改值，對於操作 `Q x`，求區間 $[L(x),R(x)]$ 的和，即 $query(R(x)) - query(L(x) - 1)$。
* 心得：這題時間卡很緊，需用 `inline`。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <bitset>
#include <cmath>
#include <cstring>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <vector>

using namespace std;
typedef unsigned long long ULL;
const int INF = 1e9;
const int MXN = 1e5 + 5;
const int MXV = 1e5 + 5;
const ULL MOD = 10009;
const ULL seed = 31;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(NULL);                                                             \
    cout.tie(NULL);                                                            \
    ios_base::sync_with_stdio(false);
int n, ti;
vector<vector<int>> G(MXV);
vector<int> L(MXV), R(MXV), sum(MXV), a(MXV);
bitset<MXN> vis, apple;

inline void dfs(int u)
{
    vis[u] = 1;
    L[u] = ++ti;
    FOR(i, 0, G[u].size())
    {
        int v = G[u][i];
        if (!vis[v])
        {
            dfs(v);
        }
    }
    R[u] = ti;
}

inline void update(int x, int v)
{
    for (; x <= n; x += (x & (-x)))
    {
        sum[x] += v;
    }
}

inline int query(int x)
{
    int ans = 0;
    for (; x > 0; x -= (x & (-x)))
    {
        ans += sum[x];
    }
    return ans;
}

int main()
{
    scanf("%d", &n);
    FOR(i, 1, n + 1) { G[i].clear(); }
    FOR(i, 1, n)
    {
        int x, y;
        scanf("%d %d", &x, &y);
        G[x].push_back(y);
        G[y].push_back(x);
    }
    vis.reset();
    ti = 0;
    dfs(1);
    apple.set();
    FOR(i, 1, n + 1) { update(L[i], 1); }

    int m;
    scanf("%d", &m);
    FOR(i, 0, m)
    {
        int x;
        char ch;
        scanf(" %c %d", &ch, &x);
        if (ch == 'Q')
        {
            printf("%d\n", query(R[x]) - query(L[x] - 1));
        }
        else
        {
            if (apple[x])
            {
                update(L[x], -1);
            }
            else
            {
                update(L[x], 1);
            }
            apple[x] = !apple[x];
        }
    }
}
```