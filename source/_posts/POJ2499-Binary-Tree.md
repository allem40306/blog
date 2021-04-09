---
title: POJ2499 Binary Tree
abbrlink: 36bc
date: 2020-09-18 16:18:21
category: POJ
tags:
- POJ
- Tree
- Math
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://poj.org/problem?id=2499)
* 題意：一顆二元樹，樹根為 $(1,1)$，如果節點為 $(a,b)$，他的左子節點為 $(a+b,b)$，右子節點為 $(a,a+b)$，給定一個節點 $(x,y)$，求根走到此點，向左和向右各多少次。
<!-- more -->
* 題解：從 $(x,y)$ 往回推，假設 $x>y$ 且 $x=ky+y%x$，那麼 $(x,y)$ 是由 $(y%x,y)$ 往左 $k$ 次到達，$y>x$ 的情況相似。因此，可以利用除法來計算出到底往左和往右走了幾步。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>
#include <map>
#include <string>
#include <vector>
using namespace std;
typedef long long LL;
const int INF = 1e9;
const int MXN = 1e5 + 5;
const int MXV = 3e5 + 5;
const LL MOD = 10009;
const LL seed = 31;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(NULL);                                                             \
    cout.tie(NULL);                                                            \
    ios_base::sync_with_stdio(false);

int main()
{
    int t = 0;
    cin >> t;
    FOR(ti, 1, t + 1)
    {
        LL i, j;
        cin >> i >> j;
        int ansL = 0, ansR = 0;
        while (i != 1 || j != 1)
        {
            // cout << i << ' ' << j << '\n';
            if (i == 1 || j == 1)
            {
                ansL += i - 1;
                ansR += j - 1;
                break;
            }
            if (i < j)
            {
                ansR += (j - j % i) / i;
                j %= i;
            }
            else
            {
                ansL += (i - i % j) / j;
                i %= j;
            }
            // cout << ansL << ' ' << ansR << "\n";
        }
        cout << "Scenario #" << ti << ":\n";
        cout << ansL << ' ' << ansR << "\n\n";
    }
}
```