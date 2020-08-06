---
title: uva10366 Faucet Flow
abbrlink: 85c4
date: 2020-08-06 22:30:32
category: UVa
tags:
- UVa
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1307)
* 題意：給以一個水槽，每兩單位有一隔板擋住，中心為 $[1,-1]$，給定左右兩邊邊界，及每個隔板高度，問至少要加給單位的水，才能溢出到最左右隔板之一。
<!-- more -->
* 題解：這題比較複雜，令中心以左最高隔板 $Lh$、中心以右最高隔板 $Rh$、$T=min(Lh,Rh)$、中心以左第 $1$ 個 $>=T$ 的隔板位置 $Lti$，中心以右第 $1$ 個 $>=T$ 的隔板位置 $Rti$，當溢出到最左右隔板之一時，$Lti$ 和 $Rti$ 中間的水量為 $V$，$Lti$ 以左的水量為 $Lt$，$Rti$ 以右的水量為 $Rt$。根據 $Lh, Rh$ 及 $Lt, Rt$ 的大小關係做出以下整理圖，根據這張圖可算出答案，我圖中沒做 $Lt==Rt$ 的結果，代表小於和等於的結果都可以套用上去。最後答案乘以 $2$ 的原因，是兩隔板區間長度為 $2$，我的 $sol$ 只算出區間為 $1$ 的結果。
* ![](https://i.imgur.com/xqcnpNV.png)
* 心得：這題整理起來滿花心思的，太多詞要搞懂，還要根據狀況算出答案，下次有空來拍影片版好了。
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
const int MXN = 1e3 + 5;
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
vector<int> Lhs(MXN), Rhs(MXN);
int L, M, R;
int Lh, Lhi, Rh, Rhi;

int sol()
{
    // cout << Lh << ' ' << Rh << '\n';
    if (Lh == Rh)
    {
        int Lt = 0, Rt = 0;
        for (int i = L, h = Lhs[L]; i > Lhi; --i)
        {
            Lt += h;
            h = max(h, Lhs[i - 1]);
        }
        for (int i = R, h = Rhs[R]; i > Rhi; --i)
        {
            Rt += h;
            h = max(h, Rhs[i - 1]);
        }
        return (Lhi + Rhi + 1) * Lh + min(Lt, Rt) * 2;
    }
    int T = min(Lh, Rh);
    int Lti = 0, Rti = 0;
    while (Lti < L && Lhs[Lti] < T)
    {
        ++Lti;
    }
    while (Rti < R && Rhs[Rti] < T)
    {
        ++Rti;
    }
    int Lt = 0, Rt = 0, t;
    if (Lh < Rh)
    {
        for (int i = L, h = Lhs[L]; i > Lhi; --i)
        {
            Lt += h;
            h = max(h, Lhs[i - 1]);
        }
        for (int i = Rti, h = T; Rhs[i] <= T; ++i)
        {
            Rt += h;
            h = max(h, Rhs[i + 1]);
        }
        t = ((Lt > Rt) ? (Lt + Rt) : (2 * Lt));
    }
    else
    {
        for (int i = R, h = Rhs[R]; i > Rhi; --i)
        {
            Rt += h;
            h = max(h, Rhs[i - 1]);
        }
        for (int i = Lti, h = T; Lhs[i] <= T; ++i)
        {
            Lt += h;
            h = max(h, Lhs[i + 1]);
        }
        t = ((Rt > Lt) ? (Lt + Rt) : (2 * Rt));
    }
    return t + (Rti + Lti + 1) * T;
}

int main()
{
    // IOS;
    int Lx, Rx;
    while (cin >> Lx >> Rx, Lx || Rx)
    {
        L = (-Lx) / 2;
        R = Rx / 2;
        Lh = Rh = 0;
        for (int i = Lx; i < 0; i += 2)
        {
            int xi = (-i) / 2;
            cin >> Lhs[xi];
            if (Lh <= Lhs[xi])
            {
                Lh = Lhs[xi];
                Lhi = xi;
            }
        }
        for (int i = 1; i <= Rx; i += 2)
        {
            int xi = i / 2;
            cin >> Rhs[xi];
            if (Rh < Rhs[xi])
            {
                Rh = Rhs[xi];
                Rhi = xi;
            }
        }
        cout << sol() * 2 << '\n';
    }
}
```