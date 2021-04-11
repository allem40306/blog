---
title: UVa10714 Ants
abbrlink: 2f1
date: 2020-08-09 20:40:05
category: UVa
tags:
- UVa
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1655)
* 題意：一支長為 $L$ 單位的棍子，上面有 $N$ 隻螞蟻，一開始不知道他們的方向，如果兩隻螞蟻相遇，他們會離開轉方向繼續走，螞蟻每秒走一單位，問最快和最慢所有螞蟻掉下棍子的時間。
<!-- more -->
* 題解：兩隻螞蟻相遇後會轉方向繼續走，其實和相遇後不會受影響兩種情況，對於本題的答案是一樣的，第二種情況，螞蟻有兩種走法，往左和往右，兩種走法時間有快慢差別。因此，最快(慢)所有螞蟻掉下棍子的時間，就是每隻螞蟻最快(慢)掉落的最大值。
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

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int L, n;
        cin >> L >> n;
        int mn = 0, mx = 0;
        vector<int> v(n);
        FOR(i, 0, n) { cin >> v[i]; }
        sort(v.begin(), v.end());
        FOR(i, 0, n)
        {
            mn = max(mn, min(v[i], L - v[i]));
            mx = max(mx, max(v[i], L - v[i]));
        }
        cout << mn << ' ' << mx << '\n';
    }
}
```