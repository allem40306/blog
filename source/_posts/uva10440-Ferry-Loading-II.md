---
title: UVa10440 Ferry Loading II
abbrlink: b646
date: 2020-08-07 20:08:18
category: UVa
tags:
- UVa
- Greedy
- DP
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1381)
* 題意：有 $M$ 台車在 A 岸 要去 B 岸，渡輪一次可以載 $N$ 台車，來回都需要 $t$ 分鐘，每台車抵達 A 岸時間不同，問最少運送次數，和最少運送次數下，把所有車載到 B 岸的時間。
<!-- more -->
* 題解 1：貪心算法，如果 $m<=n$ 就一次載完，否則就看 $m\mod n$ 是否有餘數，如果有，就先把 $m\mod n$ 台先載走，剩下的每一次都載滿 $N$ 台車。
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
    int c;
    vector<int> cars;
    cin >> c;
    FOR(ci, 0, c)
    {
        int n, t, m;
        cin >> n >> t >> m;
        cars.resize(m);
        FOR(i, 0, m) { cin >> cars[i]; }
        if (n >= m)
        {
            cout << cars[m - 1] + t << ' ' << 1 << '\n';
        }
        else if (m % n)
        {
            int finalTime = cars[m % n - 1] + 2 * t;
            for (int i = n + m % n - 1; i < m; i += n)
            {
                finalTime = max(finalTime, cars[i]) + 2 * t;
            }
            cout << finalTime - t << ' ' << m / n + 1 << '\n';
        }
        else
        {
            int finalTime = 0;
            for (int i = n - 1; i < m; i += n)
            {
                finalTime = max(finalTime, cars[i]) + 2 * t;
            }
            cout << finalTime - t << ' ' << m / n << '\n';
        }
    }
}
```
* 題解 2：DP，設 $dp[0][i]$ 為載完前 $i$ 台車最少次數下所需的時間，$dp[0][1]$ 為載完前 $i$ 台車所需的最少次數。第 $i$ 車可以從前 $N$ 台車轉移。
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
    // IOS;
    int c;
    vector<int> cars, dp[2];
    cin >> c;
    FOR(ci, 0, c)
    {
        int n, t, m;
        cin >> n >> t >> m;
        cars.resize(m + 1);
        dp[0].resize(m + 1);
        dp[1].resize(m + 1);
        fill(dp[0].begin(), dp[0].end(), INF);
        fill(dp[1].begin(), dp[1].end(), INF);
        FOR(i, 1, m + 1) { cin >> cars[i]; }
        dp[0][0] = -t;
        dp[1][0] = 0;
        dp[0][1] = cars[1] + t;
        dp[1][1] = 1;
        FOR(i, 2, m + 1)
        {
            FOR(j, max(0, i - n), i)
            {
                dp[0][i] = min(dp[0][i], max(dp[0][j] + 2 * t, cars[i] + t));
                dp[1][i] = min(dp[1][i], dp[1][j] + 1);
            }
        }
        cout << dp[0][m] << ' ' << dp[1][m] << '\n';
    }
}
```