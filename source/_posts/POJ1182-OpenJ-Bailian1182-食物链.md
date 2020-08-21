---
title: POJ1182 OpenJ_Bailian1182 食物链
abbrlink: 2dca
date: 2020-08-18 21:53:22
category: POJ
tags:
- POJ
- OpenJ_Bailian
- disjoint set
- 帶權並查集
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=1182)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/1182?lang=en_US)
* 題意：有三種動物，A 吃 B、B 吃 C、C 吃 A，現在有 N 隻動物，編號 $1$ 到 $N$，和 $K$ 段話。話有兩種，$1\ X\ Y$ 代表 $X,Y$ 是同類，$2\ X\ Y$ 代表 $X$ 吃 $Y$。如果一段話滿足三個條件之一，就是假話，否則是真話。1)與前面某些真話衝突。問有幾句假話。
<!-- more -->
* 題解 1：並查集，開三倍大小，若 $p[X]=p[Y]$ 代表 $X,Y$ 是同類，若 $p[X]=p[Y+N]$ 代表 $X$ 吃 $Y$。
* 面對第一種話，如果發現 $X,Y$ 有關係且有被捕食關係，則假話 $+1$，無關係則將 $(X,Y),(X+N,Y+N),(X+2N,Y+2N)$ 合併。
* 面對第二種話，如果發現 $X,Y$ 有關係且是同類，則假話 $+1$，無關係則將 $(X,Y+N),(X+N,Y+2N),(X+2N,Y)$ 合併。
* (如果超過 $N$ 需取餘數)
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
const int MXV = 5e4 + 5;
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

int p[3 * MXV], sz[3 * MXV];
struct DisjointSet
{
    void init(int n)
    {
        for (int i = 0; i <= n; i++)
        {
            p[i] = i;
            sz[i] = 1;
        }
    }
    int find(int u) { return u == p[u] ? u : p[u] = find(p[u]); }
    void Union(int u, int v)
    {
        u = find(u);
        v = find(v);
        if (u == v)
        {
            return;
        }
        if (sz[u] < sz[v])
        {
            swap(u, v);
        }
        sz[u] += sz[v];
        p[v] = u;
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
    int n, k;
    scanf("%d%d", &n, &k);
    djs.init(3 * n);
    int ans = 0;
    FOR(i, 0, k)
    {
        int d, x, y;
        scanf("%d%d%d", &d, &x, &y);
        if (x > n || y > n)
        {
            ++ans;
        }
        else if (d == 1)
        {
            if (djs.find(x) == djs.find(n + y) || djs.find(x) == djs.find(n + n + y))
            {
                ++ans;
            }
            else
            {
                FOR(i, 0, 3) { djs.Union(n * i + x, n * i + y); }
            }
        }
        else
        {
            if (djs.find(x) == djs.find(y) || djs.find(x) == djs.find(n + n + y))
            {
                ++ans;
            }
            else
            {
                FOR(i, 0, 3) { djs.Union(n * i + x, n * ((i + 1) % 3) + y); }
            }
        }
    }
    printf("%d\n", ans);
}
```
* 題解 2：帶權並查集。設 $rela[i]$ 為 $i$ 和父節點關係(0:和父節點同類,1:吃父節點,2:被父節點吃)。
* $find$ 參考下圖左，已知 $B\to A(X),A\to p[A](Y)$ 關係，需更新 $B\to p[A](Z)$，$Z=(X+Y)%3$。
* $union$ 如下圖右 $B\to A(X),A\to p[A](Y),B\to p[B](Z)$ 關係，需更新 $P[A]\to p[A](W)$，$W=(Y+Z-X+3)%3$。
* ![](https://i.imgur.com/oYNG9KM.png)
* 面對第一種話，如果發現 $A,B$ 有關係且有被捕食關係($rela[A]!=rela[B]$)，則假話 $+1$，面對第二種話，如果發現 $A,B$ 有關係且是同類 ($rela[A]==rela[B]$)，則假話 $+1$。無關係則需合併 $A,B$。

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

int p[MXV], rela[MXV];
struct DisjointSet
{
    void init(int n)
    {
        for (int i = 0; i <= n; i++)
        {
            p[i] = i;
            rela[i] = 0;
        }
    }
    int find(int u)
    {
        if (u != p[u])
        {
            int f = p[u];
            p[u] = find(p[u]);
            rela[u] = (rela[u] + rela[f]) % 3;
        }
        return p[u];
    }
    void Union(int u, int v, int d)
    {
        int pu = find(u);
        int pv = find(v);
        if (pu == pv)
        {
            return;
        }
        p[pv] = pu;
        rela[pv] = (rela[u] - rela[v] + 3 + (d - 1)) % 3;
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
    int n, k;
    scanf("%d%d", &n, &k);
    djs.init(n);
    int ans = 0;
    FOR(i, 0, k)
    {
        int d, x, y;
        scanf("%d%d%d", &d, &x, &y);
        if (x > n || y > n || (d == 2 && x == y))
        {
            ++ans;
        }
        else if (djs.find(x) == djs.find(y))
        {
            if ((d == 1 && rela[x] != rela[y]) ||
                (d == 2 && (rela[x] + 1) % 3 != rela[y]))
            {
                ++ans;
            }
        }
        else
        {
            djs.Union(x, y, d);
        }
    }
    printf("%d\n", ans);
}
```