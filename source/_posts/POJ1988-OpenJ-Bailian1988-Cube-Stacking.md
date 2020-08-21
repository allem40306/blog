---
title: POJ1988 OpenJ_Bailian1988 Cube Stacking
abbrlink: 50b6
date: 2020-08-18 21:52:45
category: POJ
tags:
- POJ
- OpenJ_Bailian
- disjoint set
- 帶權並查集
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=1988)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/1988?lang=en_US)
* 題意：一開始會有 $N$ 顆方塊，每顆方塊自成一堆，給定兩種操作，一種操作把含有方塊 $X$ 的一堆放到含有方塊 $Y$ 的一堆，一種操作詢問方塊 $X$ 下有幾顆方塊。
<!-- more -->
* 題解：帶權並查集，設 $ans[i]$ 為 $i$ 下方方塊數量，$sz[i]$ 為以$i$ 為並查集的根情況，該並查集個數。$Find$ 較複雜，設 $u$ 更新前的父親為 $f$，更新後的父親為 $z$(祖先)，那麼 ans 會多 $f$ 到 $z$ 的方塊數量，也就是 $ans[f]$，更新完 $p[u]$($u$ 在並查集的祖先)後，一併更新 $ans[u]$。$Union$ 相對之下比較單純，在 $u$ 併入 $v$ 的狀況，維護好 $ans[u]$ 和 $sz[v]$ 就好了。當要查詢方塊 $X$ 下有幾顆方塊，要先呼叫一次 $Find$ 更新 $ans[X]$ 再輸出。
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

int p[MXV], sz[MXV], ans[MXV];
struct DisjointSet
{
    void init(int n)
    {
        for (int i = 0; i < n; i++)
        {
            p[i] = i;
            sz[i] = 1;
            ans[i] = 0;
        }
    }
    int find(int u)
    {
        if (u != p[u])
        {
            int f = p[u];
            p[u] = find(p[u]);
            ans[u] += ans[f];
        }
        return p[u];
    }
    void Union(int u, int v)
    {
        u = find(u);
        v = find(v);
        if (u == v)
        {
            return;
        }
        p[u] = v;
        ans[u] = sz[v];
        sz[v] += sz[u];
    }
};

/*
Usage
DisjointSet djs; // declare
djs.init(int n); // initialize from vertex 0 to vertex n
djs.find(int u) // find the parent of vertex u
djs.Union(int u, int v) // union vertex u and v
*/

int main()
{
    DisjointSet djs;
    int p;
    scanf("%d", &p);
    djs.init(MXV);
    while (p--)
    {
        char ch;
        int x, y;
        scanf(" %c %d", &ch, &x);
        if (ch == 'M')
        {
            scanf(" %d", &y);
            djs.Union(x, y);
        }
        else
        {
            djs.find(x);
            printf("%d\n", ans[x]);
        }
        // printf("%c %d %d\n", ch, x, y);
    }
}
```