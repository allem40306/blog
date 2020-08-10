---
title: uva11157 Dynamic Frog
abbrlink: 7de0
date: 2020-08-10 10:59:19
category: UVa
tags:
- UVa
- greedy
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2098)
* 題意：青蛙有渡河，來回各一次，河岸之間有很多石頭，有兩種大石頭和小石頭，大石頭可以經過很多次，小石頭只能經過一次，問這隻青蛙最大的那一步，至少為多少。
<!-- more -->
* 題解：單趟渡河，不能連續經過兩個小石頭，如果在一趟渡河中連續經過兩個小石頭，另一趟的步伐勢必得加大。實作部分可以轉成，有兩隻青蛙一起渡河，第一隻青蛙經過奇數塊小石頭和所有大石頭，第二隻青蛙經過偶數塊小石頭和所有大石頭，兩隻青蛙走的路線正好對應題目要求的 "來回路線"，因此與題目等價，並且降低了實作複雜度。
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
struct Data
{
    int d;
    char kind;
    bool operator<(const Data &rhs) const { return d < rhs.d; }
};

int main()
{
    IOS;
    int t;
    vector<Data> v;
    cin >> t;
    FOR(ti, 1, t + 1)
    {
        int n, d;
        cin >> n >> d;
        v.resize(n);
        char ch;
        FOR(i, 0, n) { cin >> v[i].kind >> ch >> v[i].d; }
        sort(v.begin(), v.end());
        int ans = 0, cur = 0;
        int frog[2];
        frog[0] = frog[1] = 0;
        FOR(i, 0, n)
        {
            if (v[i].kind == 'B')
            {
                ans = max({ans, v[i].d - frog[0], v[i].d - frog[1]});
                frog[0] = frog[1] = v[i].d;
            }
            else
            {
                ans = max(ans, v[i].d - frog[cur]);
                frog[cur] = v[i].d;
                cur = 1 - cur;
            }
        }
        ans = max({ans, d - frog[0], d - frog[1]});
        cout << "Case " << ti << ": " << ans << "\n";
    }
}
```