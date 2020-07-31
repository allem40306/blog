---
title: uvaLive2519 Radar Installation
abbrlink: 828a
date: 2020-07-31 12:15:29
category: UVaLive
tags:
- UVaLive
- greedy
- 區間選點問題
- 程式競賽選修課
- 108 下
---
[題目連結](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=520)
* 題意：現在有 $N$ 個點在 $X$ 軸上方，現在要在 $X$ 軸建立一些雷達，雷達可以覆蓋半徑 $d$ 以內的點，問最小需要幾個雷達。 
<!-- more -->
* 題解：先求 $N$ 個點為中心，半徑為 $d$ 以內，和 $X$ 軸的交區間(如果沒有和 $X$ 軸有交界則無解)。這樣這題題目就變成了區間選點問題。
```cpp=
#pragma GCC optimize("O2")
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using ULL = unsigned long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
using VVI = vector<vector<int>>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
const double EPS = 1e-9;
const int MOD = 1e9 + 7;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i < (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i > (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
struct Range
{
    double L, R;
    bool operator<(Range &rhs) const { return R < rhs.R; }
};

int main()
{
    IOS;
    int n, ti = 0;
    double d;
    vector<Range> ranges;
    while (cin >> n >> d, n)
    {
        double x, y;
        bool ok = true;
        ranges.clear();
        FOR(i, 0, n)
        {
            cin >> x >> y;
            double dis = sqrt(d * d - y * y);
            if (y > d)
            {
                ok = false;
            }
            else
            {
                ranges.push_back({x - dis, x + dis});
            }
        }
        if (!ok)
        {
            cout << "Case " << ++ti << ": " << -1 << '\n';
            continue;
        }
        sort(ranges.begin(), ranges.end());
        int ans = 1;
        double curR = ranges[0].R;
        // FOR(i, 0, n) { cout << ranges[i].L << ":" << ranges[i].R << '\n'; }
        FOR(i, 1, n)
        {
            if (ranges[i].L > curR)
            {
                ++ans;
                curR = ranges[i].R;
            }
        }
        cout << "Case " << ++ti << ": " << ans << '\n';
    }
}
```