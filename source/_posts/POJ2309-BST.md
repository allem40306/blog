---
title: POJ2309 BST
abbrlink: 51ed
date: 2020-10-22 21:04:45
category: POJ
tags:
- POJ
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://poj.org/problem?id=2309)
* 題意：給定一顆無限大的完滿二元樹，從左到右依序編號 $1,2,3...$，問編好為 $n$ 的子樹下，最小和最大的編號為何?
<!-- more -->
* 題解：編號為 $n$ 的子樹，和他的最低位數有關，最 $n$ 的最低位數 $lowbit(n)$，編號為 $n$ 的子樹大小為 $2\times lowbit(n) - 1$，因為子樹號碼是連續的又 $n$ 為中間值，所以最小值和最大值為 $n - lowbit(n) + 1$ 和 $n + lowbit(n) - 1$。
```cpp=
#pragma GCC optimize(2)
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

using namespace std;
const int INF = 1e9;
const int MXN = 1e6 + 5;
const int MXV = 0;
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
#define lowbit(x) (x&(-x))

int main()
{
    int t;
    long long n;
    scanf("%d", &t);
    while(t--)
    {
        scanf("%lld", &n);
        printf("%lld %lld\n", n - lowbit(n) + 1, n + lowbit(n) - 1);
    }
}
```