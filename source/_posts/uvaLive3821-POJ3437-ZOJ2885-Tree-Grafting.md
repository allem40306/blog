---
title: UvaLive3821 POJ3437 ZOJ2885 Tree Grafting
abbrlink: 50f1
date: 2020-09-18 16:16:55
category: UvaLive
tags:
- UVaLive
- POJ
- ZOJ
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 UvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1822)
[題目連結 POJ](http://poj.org/problem?id=3437)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827366383)
* 題意：給定一棵樹，對於每個節點，將其第 $2$ 個子樹變成第 $1$ 個子樹的右子樹，第 $3$ 個子樹變成第 $2$ 個子樹的右子樹...，以此類推，問原樹和改變之後的樹分別為多少。
<!-- more -->
* 題解：對於改變後的樹，第 $i$ 個子節點到根的距離 = 父節點到根的距離 $+i$，依照此規則遞迴並更新答案。
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

string s;
int si;
int ans1, ans2;

bool hasNext()
{
    if (si == (int)s.size())
    {
        return false;
    }
    ++si;
    return true;
}

void dfs(int preD, int postD)
{
    int tmp = 0;
    // cout << preD << ' ' << postD << '\n';
    ans1 = max(ans1, preD);
    ans2 = max(ans2, postD);
    while (hasNext())
    {
        if (s[si] == 'd')
        {
            ++tmp;
            dfs(preD + 1, postD + tmp);
        }
        else
        {
            return;
        }
    }
}

int main()
{
    int ti = 0;
    while (cin >> s, s != "#")
    {
        cout << "Tree " << ++ti << ": ";
        ans1 = ans2 = 0;
        si = -1;
        dfs(0, 0);
        cout << ans1 << " => " << ans2 << '\n';
    }
}
```