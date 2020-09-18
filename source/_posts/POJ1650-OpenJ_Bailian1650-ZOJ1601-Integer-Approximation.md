---
title: POJ1650 OpenJ_Bailian1650 ZOJ1601 Integer Approximation
abbrlink: e401
date: 2020-09-18 16:20:02
category: POJ
tags:
- POJ
- OpenJ_Bailian
- ZOJ
- math
---
[題目連結 POJ](http://poj.org/problem?id=1650)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/1650?lang=en_US)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365100)
* 題意：給定一浮點數 $A$，求一個最靠近 $A$ 的分數(分子 $N$ 和分母 $D$ 皆 $\leq L$ 的正整數)。
<!-- more -->
* 題解：先讓 $N=D=1$，如果 $N/D>A$，讓 $D+=1$，反之讓 $N+=1$。
* 備註：ZOJ1601 是 EOF 版
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iomanip>
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

double A, L;
double x, y;
double ansx = 1, ansy = 1;

void update()
{
    if (abs(x / y - A) < abs(ansx / ansy - A))
    {
        ansx = x;
        ansy = y;
    }
}

int main()
{
    IOS;
    cin >> A >> L;
    x = y = 1;
    update();
    while (x < L && y < L)
    {
        // cout << x << ' ' << y << '\n';
        if (x / y > A)
        {
            y += 1.0;
        }
        else
        {
            x += 1.0;
        }
        update();
    }
    cout << fixed << setprecision(0) << ansx << ' ' << ansy << '\n';
}
```