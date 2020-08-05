---
title: uva00410 Station Balance
abbrlink: '797'
date: 2020-08-05 23:18:59
category: UVa
tags:
- UVa
- greedy
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=351)
* 題意：現在有 $S$ 試樣要放到 $C$ 跟試管中$(S\leq 2C)$，要求最小化 $IMBALANCE$，$IMBALANCE$ 為 $S$ 個試樣的平均$(AM)$和每根試管$(CM_i)$的絕對值總和。
<!-- more -->
* 題解：題目保證 $(S\leq 2C)$，所以每個試管最多放 $2$ 個試樣，並且如果要放 2 個，必須由把第 $i$ 大和第 $i$ 小放在一起，才能最小化 $IMBALANCE$。
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
const int MXN = 5;
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
    int c, s, ti = 0;
    vector<double> a(10);
    while (cin >> c >> s)
    {
        double sum = 0, avg = 0, ans = 0;
        fill(a.begin(), a.end(), 0);
        FOR(i, 0, s)
        {
            cin >> a[i];
            sum += a[i];
        }
        sort(a.begin(), a.end(), greater<double>());
        avg = sum / (double)c;
        cout << "Set #" << ++ti << '\n';
        FOR(i, 0, c)
        {
            int j = 2 * c - i - 1;
            cout << setw(2) << i << ':';
            if (a[i])
            {
                cout << fixed << setprecision(0) << ' ' << a[i];
            }
            if (a[j])
            {
                cout << fixed << setprecision(0) << ' ' << a[j];
            }
            cout << '\n';
            ans += abs((a[i] + a[j]) - avg);
        }
        cout << fixed << setprecision(5) << "IMBALANCE = " << ans << "\n\n";
    }
}
```