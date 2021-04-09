---
title: uva01494 Qin Shi Huang's National Road System
abbrlink: a5dc
date: 2020-07-28 22:29:02
category: UVa
tags:
- UVa
- Graph
- Minimum Spanning Tree
- Krusal
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4240)
* 題意：給定 $N$ 座城市座標和人口，現在要建 $N-1$ 條路來連結整個國家，在最短長度下，可以選兩個國家，免費建一條魔法路，這條路的 $\frac{A}{B}$ 要最高，$A$ 是指魔法路兩端人口和，$B$ 是非魔法路的長度。
<!-- more -->
* 題解：最短長度 ($minLength$)可用最小生成樹(Krusal 演算法)求出，魔法路需用枚舉兩端，給定點 $u,v$，$A$ 即 $u,v$ 的人口相加，$B$ 則是 $minLength$-$u,v$ 間最長的路($maxEdge(u,v)$)。$maxEdge(u,v)$ 用 dfs 求得，一次要花 $O(N)$，$C^N_2$ 的點對時間複雜度就高達 $O(N^3)$，另一種求法是一次將所有 $maxEdge(u,v)$，每遇到一個未被 visit 的點，就和其他已被 visit 的點計算出答案，這樣時間複雜度就會降到 $O(N^2)$。
```cpp=
#include <bits/stdc++.h>
using namespace std;
const int N = 1005;
struct Edge
{
    int x, y, w;
    Edge(int x, int y, int w) : x(x), y(y), w(w) {}
    bool operator<(const Edge &b) const { return w < b.w; }
};
struct DJS
{
    int p[N];
    void init()
    {
        for (int i = 0; i < N; i++)
            p[i] = i;
    }
    int f(int x) { return (x == p[x] ? x : p[x] = f(p[x])); }
} d;
vector<Edge> v, mst[N];
bitset<N> vis;
double maxEdge[N][N];
double krusal()
{
    double sum = 0;
    d.init();
    for (int i = 0; i < N; i++)
        mst[i].clear();
    for (int i = 0; i < v.size(); i++)
    {
        int fx = d.f(v[i].x), fy = d.f(v[i].y);
        if (fx == fy)
            continue;
        d.p[fx] = d.p[fy];
        sum += sqrt(v[i].w);
        mst[v[i].x].push_back(Edge(v[i].x, v[i].y, v[i].w));
        mst[v[i].y].push_back(Edge(v[i].y, v[i].x, v[i].w));
    }
    return sum;
}
void dfs(int s, int n)
{
    vis[s] = 1;
    for (int i = 0; i < mst[s].size(); i++)
    {
        int t = mst[s][i].y;
        if (vis[t])
            continue;
        double cost = sqrt(mst[s][i].w);
        for (int j = 0; j < n; j++)
        {
            if (vis[j])
            {
                maxEdge[j][t] = maxEdge[t][j] = max(maxEdge[j][s], cost);
            }
        }
        dfs(t, n);
    }
}
int main()
{
    int t, n, x[N], y[N], p[N];
    cin >> t;
    while (t--)
    {
        cin >> n;
        v.clear();
        for (int i = 0; i < n; i++)
        {
            cin >> x[i] >> y[i] >> p[i];
            for (int j = 0; j < i; j++)
            {
                v.push_back(Edge(i, j,
                                 (x[i] - x[j]) * (x[i] - x[j]) +
                                     (y[i] - y[j]) * (y[i] - y[j])));
            }
        }
        sort(v.begin(), v.end());
        double mincost = krusal(), ans = 0;
        vis.reset();
        dfs(0, n);
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < i; j++)
            {
                ans = max(ans, ((p[i] + p[j]) / (mincost - maxEdge[i][j])));
            }
        }
        cout << fixed << setprecision(2) << ans << '\n';
    }
}
```