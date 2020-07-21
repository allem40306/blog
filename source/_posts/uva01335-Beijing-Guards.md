---
title: uva01335 Beijing Guards
abbrlink: f324
date: 2020-07-21 19:52:50
category: UVa
tags:
- UVa
- binary search
- 程式競賽選修
- 108 下學期
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4081)
題意：有 $N$ 個士兵排成一環，每個士兵需要 $r_i$ 種禮物，相鄰兩士兵不能有重複的禮物，問最少需要幾種禮物。
<!-- more -->
題解：
	* 如果士兵有偶數個，那麼答案就是枚舉「相鄰兩士兵需要的禮物總和」的最大值。
	* 如果是奇數個(1 個士兵除外)則須利用二分搜找尋答案，判斷 x 種禮物是否能滿足需求的方法如下：
		* 第一位士兵需要的 $r_1$ 禮物分成一堆(Left 堆)，其餘一堆(Right 堆)
		* 偶數個士兵先拿 Left 堆，不夠再拿 Right 堆
		* 奇數個士兵先拿 Right 堆，不夠再拿 Left 堆
		* 判斷第 $n$ 位士兵是否需要拿 Left 堆的物品，如果要拿表示 x 種禮物不夠

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
int n;
vector<int> r, Left, Right;

bool ok(int x)
{
    // cout << "test: " << x << '\n';
    int L, R;
    L = Left[1] = r[1];
    R = x - L;
    Right[1] = 0;
    FOR(i, 2, n + 1)
    {
        if(i % 2 == 1)
        {
            Right[i] = min(R - Right[i - 1], r[i]);
            Left[i] = r[i] - Right[i];
        }
        else
        {
            Left[i] = min(L - Left[i - 1], r[i]);
            Right[i] = r[i] - Left[i];
        }
        // cout << i << ' ' << Left[i] << ' ' << Right[i] << '\n';
    }
    return Left[n] == 0;
}

int main()
{
    // IOS;
    while(cin >> n, n)
    {
        r.resize(n + 5);
        Left.resize(n + 5);
        Right.resize(n + 5);
        FOR(i, 1, n + 1) { cin >> r[i]; }
        if(n == 1)
        {
            cout << r[1] << '\n';
            continue;
        }
        int L = 0, R = 0;
        r[n + 1] = r[1];
        FOR(i, 1, n + 1) { L = max(L, r[i] + r[i + 1]); }
        if(n % 2)
        {
            FOR(i, 1, n + 1) { R = max(R, r[i] * 3); }
            while(L != R)
            {
                // cout << L << ' ' << R << '\n';
                int M = L + ((R - L) >> 1);
                if(ok(M))
                {
                    R = M;
                }
                else
                {
                    L = M + 1;
                }
            }
        }
        cout << L << '\n';
    }
}
```