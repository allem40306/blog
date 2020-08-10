---
title: uva11264 Coin Collector
abbrlink: bde8
date: 2020-08-10 12:10:35
category: UVa
tags:
- UVa
- greedy
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2231)
* 題意：有 $n$ 種面額不同($C_i,C_2,C_3,...,C_n$)的硬幣，現在要從提款機提取一些錢，提款機會從面額高到低的硬幣依序給付，求最多可以拿到幾種不一樣的硬幣。
<!-- more -->
* 題解：如果一種硬幣組合 $X_1,X_2,X_3,...,X_m$ 要每一種都拿到，必須滿足 $\Sigma_{i=1}^{m-1}X_i<X_m$，否則至少會有一種硬幣無法拿到，同理必須滿足所有的 $\Sigma_{i=1}^{m-j}X_i<X_{m-j+1}$($j\in[1,m-1]$)，才能拿到組合中所有種類硬幣。實際做法會從硬幣小的開始挑選，如果目前的組合加上 $C_i$ 小於 $C_{i+1}$，那麼就可以把 $C_i$ 納入組合中。
```cpp=
#pragma GCC optimize("O2")
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using ULL = unsigned long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
using VVI = vector<vector<int>>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
const double EPS = 1e-9;
const int MOD = 1e9+7;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i < (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i > (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int t;
    vector<int> coins;
    cin >> t;
    while(t--)
    {
        int n;
        cin >> n;
        coins.resize(n);
        FOR(i, 0, n) { cin >> coins[i]; }
        int sum = 0, ans = 1;
        FOR(i,0,n-1)
        {
            if(sum+coins[i]< coins[i + 1])
            {
                ++ans;
                sum += coins[i];
            }
        }
        cout << ans << '\n';
    }
}
```