---
title: uva11722 Joining with Friend
abbrlink: a114
date: 2020-08-10 12:11:13
category: UVa
tags:
- UVa
- Geometry
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2769)
* 題意：有兩個好朋友會坐不同路線的火車經過同一個車站，分別會在 $[t_1, t_2]$ 和 $[s_1, s_2]$ 之間抵達，火車會停留 $w$ 分鐘，問他們會在同一時間都在該火車站的機率為和。
<!-- more -->
* 題解：這題要轉為幾何，變成求 $x=t1,x=t2,y=s1,y=s2$ 所圍成的矩形面積，跟在 $y=x+w,y=x-w$ 兩條線之內的面積比例。`sol(b)` 函式用來算出 $y=x+b$ 右下方和矩形所交會的面積，有 6 種情況，如下圖，根據 $y=x+w$ 和$x=t1,x=t2$ 來判斷，`sol(w)-sol(-w)` 就是兩條線交會出的面積，最後除以矩形整體面積就是答案。
* ![](https://i.imgur.com/ylEznKz.jpg)

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
double t1, t2, s1, s2;

double sol(double w) // y=x+w, calc right-buttom area
{
    double totArea = (t2 - t1) * (s2 - s1);
    double y1 = t1 + w, y2 = t2 + w;
    if (y2 <= s1)
    {
        return 0;
    }
    if (y1 <= s1)
    {
        if (y2 <= s2)
        {
            return (y2 - s1) * (y2 - s1) * 0.5;
        }
        return ((t2 - (s2 - w)) + (t2 - (s1 - w))) * (s2 - s1) * 0.5;
    }
    if (y1 <= s2)
    {
        if (y2 <= s2)
        {
            return ((t1 - (s1 - w)) + (t2 - (s1 - w))) * (t2 - t1) * 0.5;
        }
        return totArea - (s2 - (t1 + w)) * (s2 - (t1 + w)) * 0.5;
    }
    return totArea;
}

int main()
{
    IOS;
    int t;
    cin >> t;
    FOR(ti, 1, t + 1)
    {
        double w;
        cin >> t1 >> t2 >> s1 >> s2 >> w;
        double ans = sol(w) - sol(-w);
        ans /= (s2 - s1) * (t2 - t1);
        cout << "Case #" << ti << ": ";
        cout << fixed << setprecision(8) << ans << '\n';
    }
}
```