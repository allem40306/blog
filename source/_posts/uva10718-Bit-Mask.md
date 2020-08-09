---
title: uva10718 Bit Mask
abbrlink: b7c3
date: 2020-08-09 20:41:38
category: UVa
tags:
- UVa
- greedy
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1659)
* 題意：求一個數字 $M$ 在 $[L,U]$ 之間，使得 $N\ or\ M$ 最大，如果有多個 $M$ 滿足，輸出最小的。
<!-- more -->
* 題解：把每個 bit 拆開來判斷，一開始設 $M=0$，設 $N_i$ 為 $N$ 個第 $i$ 位 bit，有兩種情況可以讓 $M+=2^i$，第一種是 $N_i=0$ 且 $M+2^i<=U$ 的話，第二種是 $N_i=1$ 且 如果 $M$ 不加 $2^i$ 就會 $<L$。
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
    unsigned int N, L, U;
    while (cin >> N >> L >> U)
    {
        unsigned int ans = 0;
        FORD(i, 31, 0 - 1)
        {
            if (((N & (1U << i)) && ((ans | (1U << i)) <= L)) ||
                (!(N & (1U << i)) && ((ans | (1U << i)) <= U)))
            {
                ans |= (1 << i);
            }
        }
        cout << ans << '\n';
    }
}
```