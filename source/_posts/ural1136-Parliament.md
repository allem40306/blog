---
title: ural1136 Parliament
abbrlink: b407
date: 2020-09-18 16:16:11
category: ural
tags:
- ural
- tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](https://acm.timus.ru/problem.aspx?space=1&num=1136)
* 題意：給定一顆二元搜尋樹的後序，依照右子樹、左子樹、根，輸出這棵樹。
<!-- more -->
* 題解：後序的最後一個數字為根，從左到右搜尋，第一個 $\geq R$ 的位置 $x$ 是左右子樹的界線($x$ 包含在右子樹)。接著依右子樹、左子樹、根搜尋，輸出值。
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
vector<int> v;

int ansp, ansv;
void build(int L, int R)
{
    // cout << L << ' ' << R << '\n';
    int Lroot = 0;
    for (; Lroot < R; ++Lroot)
    {
        if (v[Lroot] >= v[R])
        {
            break;
        }
    }
    if (Lroot < R)
    {
        build(Lroot, R - 1);
    }
    if (L < Lroot)
    {
        build(L, Lroot - 1);
    }
    cout << v[R] << '\n';
}

int main()
{
    IOS;
    int n;
    cin >> n;
    v.resize(n);
    FOR(i, 0, n) { cin >> v[i]; }
    build(0, n - 1);
}
```