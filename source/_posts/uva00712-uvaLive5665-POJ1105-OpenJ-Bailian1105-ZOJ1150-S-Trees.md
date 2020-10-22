---
title: uva00712 uvaLive5665 POJ1105 OpenJ_Bailian1105 ZOJ1150 S-Trees
abbrlink: ea4d
date: 2020-09-18 16:12:51
category: uva
tags:
- uva
- uvaLive
- POJ
- OpenJ_Bailian
- ZOJ
- tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=653)
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3566)
[題目連結 POJ](http://poj.org/problem?id=1105)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/1105?lang=en_US)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827364649)
* 題意：給定一顆層數為 $N+1$ 的完美二元樹，及每個葉節點的值，並告訴你在第 $i$ 層要往左還是右。問依照 $x_1,x_2,x_3,..,x_n$ 的值向左 ($x_i=0$) 或向右 ($x_i=1$)，問最終會到葉節點的值。
<!-- more -->
* 題解：這題主要是輸入的處理要費心思。判斷最後會落在哪個點，其實就和二進位有關，如果往左走，等同二進位表示下加了 $0$，反之等同二進位表示下加了 $1$。
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
const int MXV = 3e5 + 5;
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
int main()
{
    int n, m, ti = 0;
    vector<int> order;
    string s, r;
    while (cin >> n, n)
    {
        order.resize(n);
        char ch;
        FOR(i, 0, n) { cin >> ch >> order[i]; }
        cin >> s;
        cout << "S-Tree #" << ++ti << ":\n";
        cin >> m;
        FOR(i, 0, m)
        {
            cin >> r;
            int x = 0;
            FOR(j, 0, n)
            {
                if (r[order[j] - 1] == '0')
                {
                    x = 2 * x;
                }
                else
                {
                    x = 2 * x + 1;
                }
            }
            cout << s[x];
        }
        cout << "\n\n";
    }
}
```