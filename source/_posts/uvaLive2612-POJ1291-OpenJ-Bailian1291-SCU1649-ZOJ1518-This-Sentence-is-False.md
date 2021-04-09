---
title: uvaLive2612 POJ1291 OpenJ_Bailian1291 SCU1649 ZOJ1518 This Sentence is False
abbrlink: 8ebd
date: 2020-08-18 21:55:15
category: uvaLive
tags:
- uvaLive
- POJ
- OpenJ_Bailian
- SCU
- ZOJ
- Disjoint Set
- 帶權並查集
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=613)
[題目連結 POJ](http://poj.org/problem?id=1291)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/1291?lang=en_US)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=1649)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365017)
* 題意：給定 $N$ 句話，第 $i$ 句話會指出第 $J_i$ 是對/錯的，問最多有幾句話是對的。
<!-- more -->
* 題解：帶權並查集，如果第 $i$ 句話會指出第 $J_i$ 是對，在中間建立一條權重為 0 的邊，否則建立一條權重為 1 的邊。最後我注重的是和根的距離是否奇數或偶數，可以把權重 `&1` 就行$Find$ 的部分，設 $u$ 更新前的父親為 $f$，更新後的父親為 $z$ (祖先)，$dis(u,z)=dis(u,f)+dis(f,z)$，所以要在更新父節點後，依此式更新 $d[u]$。最後先把每一顆並查集距離根為奇數、偶數的各數算出來，分別取最大值加總，即為答案。
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

int p[MXV], d[MXV];
bool ok;
struct DisjointSet
{
    void init(int n)
    {
        for (int i = 0; i <= n; i++)
        {
            p[i] = i;
            d[i] = 0;
        }
    }
    int find(int u)
    {
        if (u != p[u])
        {
            int f = p[u];
            p[u] = find(p[u]);
            d[u] = (d[u] + d[f]) & 1;
        }
        return p[u];
    }
    void Union(int u, int v, int dis)
    {
        int pu = find(u);
        int pv = find(v);
        if (pu == pv)
        {
            if (((d[u] + d[v]) & 1) != dis)
            {
                ok = false;
            }
        }
        else
        {
            p[pv] = pu;
            d[pv] = (d[u] + d[v] + dis) & 1;
        }
    }
};

/*
Usage
DisjointSet djs; // declare
djs.init(int n); // initialize from vertex 0 to vertex n
djs.find(int u) // find the parent of vertex u
djs.Union(int u, int v) // union vertex u and v
*/
int sum[MXN][2];

int main()
{
    DisjointSet djs;
    char s[20];
    int n;
    while (scanf("%d", &n), n)
    {
        djs.init(n);
        ok = true;
        FOR(i, 1, n + 1)
        {
            int j;
            scanf("%s", s);
            scanf("%d", &j);
            scanf("%s", s);
            scanf("%s", s);
            int dis = ((s[0] == 't') ? 0 : 1);
            djs.Union(i, j, dis);
        }
        if (!ok)
        {
            printf("Inconsistent\n");
        }
        else
        {
            memset(sum, 0, sizeof(sum));
            FOR(i,1,n+1)
            {
                int fi = djs.find(i);
                // cout << i << ':' << fi << ' ' << (d[i] & 1) << '\n';
                ++sum[fi][d[i] & 1];
            }
            int ans = 0;
            FOR(i,1,n+1)
            {
                ans+=max(sum[i][0],sum[i][1]);
            }
            printf("%d\n", ans);
        }
    }
}
```