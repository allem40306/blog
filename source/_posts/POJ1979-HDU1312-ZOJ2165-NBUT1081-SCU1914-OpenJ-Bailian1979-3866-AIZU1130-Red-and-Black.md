---
title: >-
  POJ1979 HDU1312 ZOJ2165 NBUT1081 SCU1914 OpenJ_Bailian1979(3866) AIZU1130 Red
  and Black
abbrlink: 342e
date: 2020-08-15 16:25:32
category: POJ
tags:
- POJ
- HDU
- ZOJ
- NBUT
- SCU
- OpenJ_Bailian
- AIZU
- 遞迴
---
[題目連結 POJ](http://poj.org/problem?id=1979)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=1312)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365664)
[題目連結 NBUT](https://ac.2333.moe/Problem/view.xhtml?id=1081)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=1914)
[題目連結 OpenJ_Bailian 1979](http://bailian.openjudge.cn/practice/1979?lang=en_US)
[題目連結 OpenJ_Bailian 3866](http://bailian.openjudge.cn/practice/3866?lang=en_US)
[題目連結 AIZU](http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1130)
* 題意：一個房間地板有紅瓦和黑瓦，一個人站在黑瓦，他可以上下左右移動，但不能走到紅瓦，問他可以走到多少黑瓦中。
<!-- more -->
* 題解：經典 DFS、BFS，因為上課的緣故用了遞迴來做。
```cpp=
#pragma GCC optimize(2)
#include <iostream>
#include <queue>
#include <vector>
#include <string>
using namespace std;
const int INF = 1e9;
const int MXN = 0;
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
vector<string> room;
int n, m;
int ans;
int d[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

void dfs(int x, int y)
{
    // cout << x << ' ' << y << '\n';
    FOR(i, 0, 4)
    {
        int _x = x + d[i][0];
        int _y = y + d[i][1];
        //     cout << _x << '-' << _y << '\n';
        // if (_x >= 0 && _x < n && _y >= 0 && _y < m)
        // {
        //     cout << room[_x][_y] << '\n';
        // }
        if (_x >= 0 && _x < m && _y >= 0 && _y < n && room[_x][_y] == '.')
        {
            room[_x][_y] = '@';
            ++ans;
            dfs(_x, _y);
        }
    }
}

int main()
{
    IOS;
    while (cin >> n >> m, n || m)
    {
        room.resize(m);
        FOR(i, 0, m) { cin >> room[i]; }
        int x = 0, y = 0;
        FOR(i, 0, m) FOR(j, 0, n)
        {
            if (room[i][j] == '@')
            {
                x = i;
                y = j;
            }
        }
        ans = 1;
        // cout << x << ' ' << y << '\n';
        dfs(x, y);
        cout << ans << '\n';
    }
}
```