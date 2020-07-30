---
title: uva01073 Glenbow Museum
abbrlink: cf4c
date: 2020-07-30 10:59:00
category: UVa
tags:
- UVa
- dp
- math
- combinatorics
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3514)
* 題意：給定一整數 $n$，問，這有多少長度為 $n$ 並由 `OR` 組成的字串，可以代表幾種直角多邊形，其中 `R` 代表轉 90 度，`O` 代表轉 270 度。
<!-- more -->
* 題解 1：這題要需要分析一些事情。(1)每一個 `R` 都要緊連著一個 `O`。(2)另外還要 4 個 `R`，才能讓這個多邊形剛好轉 360 度。所以 `R` 比 `O` 多 4 個。`R` 有 $\frac{n+4}{2}$ 個，`O` 有 $\frac{n-4}{2}$ 個。我們用 dp 來解這題。定義 $dp[i][j][k]$ 為有 $i$ 個 `R`，$j$ 組 `RR` 相連的情況下，第一個字是 $K(0:R,1:O)$，最後一個是為 `R`。轉移式有兩種，一種是在字串後加上 `OR`($dp[i][j][k]$ -> $dp[i+1][j][k]$)，一種是在字串後加上 `R`($dp[i][j][k]$ -> $dp[i+1][j+1][k]$)。最後答案為 $dp[r][4][0]$(頭是 R、尾補 O)$ + dp[r][4][1]$(頭是 O、尾是 R)$ + dp[r][3][0]$(頭尾都是 R，一組 RR 被拆開)($r$ 為 `R` 個數)。
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
LL dp[MXN][5][2] = {}, ans[MXN] = {};

int main()
{
    // IOS;
    FOR(k, 0, 2)
    {
        dp[1][0][k] = 1;
        FOR(i, 2, MXN) FOR(j, 0, 5)
        {
            dp[i][j][k] = dp[i - 1][j][k];
            if (j > 0)
            {
                dp[i][j][k] += dp[i - 1][j - 1][k];
            }
            // cout << i << ' ' << j << ' ' << k << ' ' << dp[i][j][k] << '\n';
        }
        FOR(i, 1, MXN)
        {
            if (i % 2 || i == 2)
            {
                continue;
            }
            int r = (i + 4) / 2;
            ans[i] = dp[r][4][0] + dp[r][4][1] + dp[r][3][0];
        }
    }
    int n, ti = 0;
    while (cin >> n, n)
    {
        cout << "Case " << ++ti << ": " << ans[n] << '\n';
    }
}
```
* 題解 2：這題可以用排列組合來想，另 $r=\frac{n+4}{2},o=\frac{n-4}{2}$，分成頭是 `R` 和是 `O` 兩種，第一種要在 $r$ 個 `R` 中選 $o$ 個 `R` 在其右邊插入 `O`第二種要在 $r-1$ 個 `R` 中選 $o-1$ 個 `R` 在其右邊插入 `O`，答案就是 $C_{o}^{r}+C_{o-1}^{r-1}=C_{4}^{r}+C_{4}^{r-1}$。
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

LL cn4(LL x) { return x * (x - 1) * (x - 2) * (x - 3) / 24; }

int main()
{
    IOS;
    int ti = 0;
    LL n;
    while (cin >> n, n)
    {
        cout << "Case " << ++ti << ": ";
        if (n % 2 || n == 2)
        {
            cout << "0\n";
        }
        else
        {
            int r = (n + 4) / 2;
            cout << cn4(r) + cn4(r - 1) << '\n';
        }
    }
}
```
* 心得：之前有聽說過有些題目明明不是想出數論，卻被數論解破，這一題就是這種類型吧，幫出題者 QQ。