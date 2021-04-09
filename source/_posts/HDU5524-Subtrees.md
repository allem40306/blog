---
title: HDU5524 Subtrees
abbrlink: cfb2
date: 2020-09-18 16:11:19
category: HDU
tags:
- HDU
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://acm.hdu.edu.cn/showproblem.php?pid=5524)
* 題意：給定一顆 $N$ 個點的完全二元樹，問有幾個不同 `size` 的子樹。
<!-- more -->
* 題解：對於一顆滿二元樹，答案會是這棵樹的高度；對於一顆非滿二元樹，每往下一層，答案就 `+1`
* 參考：https://blog.csdn.net/kyoma/article/details/52072829
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
LL n;
LL maxn, ans;

void sol(LL x)
{
    LL L = x, R = x, dep = 0;
    for (L = x; 2 * L <= n; ++dep)
    {
        L *= 2;
    }
    for (; 2 * R + 1 <= n;)
    {
        R = 2 * R + 1;
    }
    if (L <= R)
    {
        maxn = max(maxn, dep);
    }
    else
    {
        ++ans;
        sol(2 * x);
        sol(2 * x + 1);
    }
}

int main()
{
    IOS;
    while (cin >> n)
    {
        maxn = ans = 0;
        sol(1);
        cout << maxn + ans + 1 << '\n';
    }
}
```