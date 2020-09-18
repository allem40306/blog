---
title: uva00679 Dropping Balls
abbrlink: 369a
date: 2020-09-18 16:11:59
category: uva
tags:
- uva
- Tree
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=620)
* 題意：給定一顆層數 $D$ 為完美二元樹，每次會從樹根放一顆球，每個節點都有一個標記，一開始標記為左，有一顆球經過，標記會為右，再一顆經過，標記會為左，以此類推，每顆球都會依標記決定要往哪顆子樹走，問第 $I$ 顆球最後會在哪顆葉節點。
<!-- more -->
* 題解：判斷最後會落在哪個點，其實就和二進位有關，如果往左走，等同二進位表示下加了 $0$，反之等同二進位表示下加了 $1$。
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
        LL d, i, ans = 1;
        cin >> d >> i;
        i--;
        while(--d)
        {
            if(i & 1)
            {
                ans = ans * 2 + 1;
            }
            else
            {
                ans = ans * 2;
            }
            i >>= 1;
        }
        cout << ans << '\n';
    }
}
```	