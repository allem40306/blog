---
title: UvaLive2926 POJ3067 ZOJ3129 Japan
abbrlink: f60a
date: 2020-08-21 17:04:16
category: UVaLive
tags:
- UVaLive
- POJ
- ZOJ
- Bit Index Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 UvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=927)
[題目連結 POJ](http://poj.org/problem?id=3067)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827367544)
* 題意：在東西兩岸各有 $N,M$ 座城市，和 $K$ 條橫跨東西岸的高速公路，城市編號由北至南遞增，問這些高速公路共交錯了幾次。
<!-- more -->
* 題解：設高速公路東西岸分別連結編號 $x,y$ 號城市，兩條公路 $i,j$ 交錯的必要條件為 $x_i<x_j$ 且 $y_i>y_j$。先以東岸編號 ($x$) 由小到大排序，再以西岸編號 ($y$) 由小到大排序。這時保證遍歷的過程東岸編號 ($x$) 會遞增，因此用 `樹狀數組(BIT)` 維護已經遍歷過的高速公路西岸編號 ($y$) ，對於每條高速公路，先將答案加上所有大於目前 $y$ 的條數(會交錯的條數)，再將目前 $y$ 加入 `BIT` 維護。
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
typedef pair<int, int> PII;
typedef long long LL;
const int INF = 1e9;
const int MXN = 1e3 + 5;
const int MXV = 1e5 + 5;
const LL MOD = 10009;
const LL seed = 31;
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
vector<LL> sum(MXN);

inline void update(int x, int v)
{
    for (; x < MXN; x += (x & (-x)))
    {
        sum[x] += v;
    }
}

inline LL query(int x)
{
    LL ans = 0;
    for (; x > 0; x -= (x & (-x)))
    {
        ans += sum[x];
    }
    return ans;
}

int main()
{
    int t, ti = 0;
    scanf("%d", &t);
    while (t--)
    {
        int m, n, k;
        scanf("%d %d %d", &m, &n, &k);
        vector<PII> v(k);
        FOR(i, 0, k) { scanf("%d %d", &v[i].F, &v[i].S); }
        sort(v.begin(), v.end());
        fill(sum.begin(), sum.end(), 0);
        LL ans = 0;
        FOR(i, 0, k)
        {
            ans += i - query(v[i].S);
            update(v[i].S, 1);
        }
        printf("Test case %d: %lld\n", ++ti, ans);
    }
}
```