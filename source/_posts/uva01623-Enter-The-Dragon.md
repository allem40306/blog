---
title: uva01623 Enter The Dragon
abbrlink: 99c4
date: 2020-08-06 21:47:54
category: UVa
tags:
- UVa
- Map
- Greedy
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4498)
* 題意：有 $N$ 座湖，一開始是滿的，現在給接下來 $M$ 天的資訊 $r_i$，代表不會下雨$(r_i=0)$或是會下在第 $r_i$ 座湖，如果下在乾枯的湖，湖就會漲滿，若在滿的湖上下雨，則會大淹水，為了防止淹水，有一隻龍可以在每一個非下雨天，喝到一座湖的水，求一種喝水的順序，使得沒有演水的是發生。
<!-- more -->
* 題解：對於每個下雨天，我們就從同一座湖上次下雨的隔天開始，找出最早未下雨而且龍還沒被指定要喝哪一座湖的日子 $D_{drink}$。這裡用 `map` 來維護非下雨天，用 `lower_bound` 找尋 $D_{drink}$，找到後 $D_{drink}$ 無法在安排龍喝其他座湖的水，必須移出 `map`。時間複雜度為 $O(M\log M)$，$M$ 為迭代每個下雨天的複雜度(`Line42-59`)，$\log M$ 為 `map` 操作的時間。
* 心得：這題不知道為什麼我用 `vector<int>` 會 `WA`，後來改用 `array` 方式就過了。
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
const int MXN = 1e6 + 5;
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
int r[MXN], ans[MXN], lastRain[MXN];
set<int> noRainDay;

int main()
{
    IOS;
    int z;
    cin >> z;
    while (z--)
    {
        int n, m;
        cin >> n >> m;
        memset(ans, -1, sizeof(ans));
        memset(lastRain, 0, sizeof(lastRain));
        noRainDay.clear();
        FOR(i, 1, m + 1) { cin >> r[i]; }
        bool ok = true;
        FOR(i, 1, m + 1)
        {
            if (r[i] == 0)
            {
                ans[i] = 0;
                noRainDay.insert(i);
                continue;
            }
            auto it = noRainDay.lower_bound(lastRain[r[i]]);
            if (it == noRainDay.end())
            {
                ok = false;
                break;
            }
            ans[*it] = r[i];
            lastRain[r[i]] = i;
            noRainDay.erase(*it);
        }
        if (ok)
        {
            cout << "YES\n";
            bool delimiter = false;
            FOR(i, 1, m + 1)
            {
                if (ans[i] == -1)
                {
                    continue;
                }
                if (delimiter)
                {
                    cout << ' ';
                }
                delimiter = true;
                cout << ans[i];
            }
            cout << '\n';
        }
        else
        {
            cout << "NO\n";
        }
    }
}
```