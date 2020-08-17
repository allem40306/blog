---
title: uvaLive6711 HDU4821 String
abbrlink: '4932'
date: 2020-08-17 16:56:24
category: uvaLive
tags:
- uvaLive
- HDU
- hash
- silding window
---
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4723)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=4821)
* 題意：給定一字串 $S$ 和兩整數 $M,L$，對於任意一個長度為 $ML$ 的子字串，將其切成 $M$ 段長度 $L$ 的小字串，如果這 $M$ 段小字串相異，則我們說這個子字串為 "recoverable"，求 "recoverable" 字串數。
<!-- more -->
* 題解：做 $L$ 次 `silding window`，每次一開始把 $M$ 段長度為 $L$ 的字串 hash 值放入 `map` 計數，之後增加右側一組字串，減去左邊一組字串，如果 `map.size()==M`，代表 $M$ 段字串相異，"recoverable" 字串數 $+1$。
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
typedef unsigned long long ULL;
const int INF = 1e9;
const int MXN = 1e5 + 5;
const int MXV = 0;
const ULL MOD = 10009;
const ULL seed = 31;
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
int m, L, sz;
ULL val[MXN], _pow[MXN];
char s[MXN];

ULL gethash(int L, int R) { return val[R] - val[L - 1] * _pow[R - L + 1]; }

map<ULL, int> mp;
int main()
{
    _pow[0] = 1;
    FOR(i, 1, MXN) { _pow[i] = _pow[i - 1] * seed; }
    while (scanf("%d %d", &m, &L) != EOF)
    {
        scanf("%s", s + 1);
        sz = strlen(s + 1);
        val[0] = 0;
        FOR(i, 1, sz + 1) { val[i] = val[i - 1] * seed + (s[i] - 'a'); }
        int ans = 0;
        for (int i = 1; i <= L && i + m * L <= sz; ++i)
        {
            // cout << i << ':' << '\n';
            mp.clear();
            for (int j = i; j < i + m * L; j += L)
            {
                ULL tmp = gethash(j, j + L - 1);
                // cout << tmp << '\n';
                mp[tmp]++;
            }
            if ((int)mp.size() == m)
            {
                ++ans;
            }
            for (int j = i; j + m * L + L - 1 <= sz; j += L)
            {
                ULL tmp = gethash(j, j + L - 1);
                --mp[tmp];
                if (mp[tmp] == 0)
                {
                    mp.erase(tmp);
                }
                ++mp[gethash(j + m * L, j + m * L + L - 1)];
                if ((int)mp.size() == m)
                {
                    ++ans;
                }
            }
        }
        cout << ans << '\n';
    }
}
```