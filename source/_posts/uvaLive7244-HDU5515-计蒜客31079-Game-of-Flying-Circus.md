---
title: uvaLive7244 HDU5515 计蒜客31079 Game of Flying Circus
abbrlink: a60d
date: 2020-08-25 22:13:48
category: UVaLive
tags:
- UVaLive
- HDU
- 计蒜客
- Binary Search
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=5256)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=5515)
[題目連結 计蒜客](https://nanti.jisuanke.com/t/A1973)
* 題意：有一款遊戲 "Flying Circus"，在一個正方形的場地舉行，四個角分別為點 $1,2,3,4$，兩名玩家一開始在 $1$ 號點，要依序觸摸 $2,3,4,1$ 對於任意一個點，誰先摸到就先得分。如果同時到同一個點，可以互相 fight，贏家得分，為求公平在到達點 $2$ 前不能 fight。有兩名玩家，已知 Shion 速度快，會規矩地走一圈，Asuka 速度慢，但打得贏 Shion。給定兩人的速度，以及 Asuka 跟 Shion fight 後，Shion 昏迷秒數，問 Asuka 是否能贏。
<!-- more -->
* 題解：分成不同情況討論。(1)如果速度相同，Asuka 勝。(2)Asuka 可在點 $2$ 到點 $3$ 之間攔截 Shion，並且可以比他快到點 $4$，Asuka 勝。(3)Asuka 可在點 $3$ 到點 $4$ 之間攔截 Shion，並且可以比他快到點 $1$，Asuka 勝。其餘狀況 Shion 勝。對於 (2)(3) 種情況，可以用二分搜判斷是否有可能。
```cpp=
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> PII;
typedef long long LL;
const int INF = 1e9;
const int MXN = 3e5 + 5;
const int MXS = 1e7 + 5;
const int MXW = 26;
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
double T, v1, v2, T1, T2;

bool sol()
{
    if (v1 == v2)
    {
        return true;
    }
    if (v1 * v1 * 2 > v2 * v2)
    {
        double L = 0, R = 300, M;
        FOR(i, 0, 150)
        {
            M = (L + R) / 2;
            double d1 = sqrt(300 * 300 + M * M);
            double d2 = 300 + M;
            (d1 / v1 > d2 / v2) ? (L = M) : (R = M);
        }
        double t1 = sqrt(300 * 300 + L * L) / v1 + L / v1 + 2 * T1;
        double t2 = 3 * T2 + T;
        return t1 <= t2;
    }
    if (v1 * 3 > v2)
    {
        double L = 0, R = 300, M;
        FOR(i, 0, 150)
        {
            M = (L + R) / 2;
            double d1 = sqrt(300 * 300 + M * M);
            double d2 = 900 - M;
            (d1 / v1 > d2 / v2) ? (R = M) : (L = M);
        }
        double t1 = sqrt(300 * 300 + L * L) / v1 +
                    sqrt(300 * 300 + (300 - L) * (300 - L)) / v1 + 3 * T1;
        double t2 = 4 * T2 + T;
        return t1 <= t2;
    }
    return false;
}

int main()
{
    int t;
    scanf("%d", &t);
    FOR(i, 1, t + 1)
    {
        scanf("%lf %lf %lf", &T, &v1, &v2);
        T1 = 300 / v1;
        T2 = 300 / v2;
        bool res = sol();
        if(res)
        {
            printf("Case #%d: Yes\n", i);
        }
        else
        {
            printf("Case #%d: No\n", i);
        }
    }
}
```