---
title: UVa11459 Calculator Conundrum
abbrlink: '4305'
date: 2020-07-21 20:12:58
category: UVa
tags:
- UVa
- Math
- Floyd Cycle Detection
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=onlinejudge&page=show_problem&problem=2544)
題意：問 $k, k^2, k^3, k^4,..$ 中取最大 $n$ 位，可以得出的最大數字為多少。
<!-- more  -->
題解：這題最後會出現循環，所以可以利用 `set` 或是 `floyd cycle detection` 來做，這裡用後者。`floyd cycle detection` 做法是用兩個指針，一個一次往前一步($k^m$)，一個往前兩步($k^{2m}$)，當相遇的時候表示已將整個環走一遍了。取前 $n$ 位則利用了 `stringstream`，先將數字藉由 `stringstream` 轉成字串取前 $n$ 位，再將字串導入另一個 `stringstream` 轉成數字。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
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

LL next(LL k, int n)
{
    stringstream ss;
    ss << (LL)k * k;
    string s = ss.str();
    if ((int)s.size() > n)
    {
        s = s.substr(0, n);
    }
    stringstream ss2(s);
    LL ret;
    ss2 >> ret;
    return ret;
}

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int n;
        LL k;
        cin >> n >> k;
        LL ans = k;
        LL k1 = k, k2 = k;
        do
        {
            k1 = next(k1, n);
            // ans = max(ans, k1);
            k2 = next(k2, n);
            ans = max(ans, k2);
            k2 = next(k2, n);
            ans = max(ans, k2);
        } while (k1 != k2);
        cout << ans << '\n';
    }
}
```