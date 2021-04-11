---
title: UVa00539 POJ2258 ZOJ1947 The Settlers of Catan
abbrlink: 3e8c
date: 2020-08-15 16:30:17
category: UVa
tags:
- UVa
- POJ
- ZOJ
- DFS
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 UVa](https://onlinejudge.org/index.php?option=onlinejudge&Itemid=8&page=show_problem&problem=480)
[題目連結 POJ](http://poj.org/problem?id=2258)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365446)
* 題意：給定一張 $N$ 個點 $M$ 條邊的圖，問圖上最長不重複的路徑。
<!-- more -->
* 題解：DFS，每遇到一個點就紀錄拜訪過，離開的時候取消紀錄，接著走其他沒被記錄走過的點，在 DFS 途中更新答案。
```cpp=
#include <cstring>
#include <iostream>
#include <vector>

using namespace std;
const int N = 30;
struct Edge
{
    Edge(){};
    Edge(int _from, int _to) : from(_from), to(_to) {}
    int from, to;
};
int ans;
bool vis[N];
vector<Edge> E;
vector<int> G[N];

void init()
{
    E.clear();
    for (int i = 0; i < N; i++)
    {
        G[i].clear();
    }
}

void add_Edge(int from, int to)
{
    G[from].push_back(E.size());
    G[to].push_back(E.size());
    E.push_back(Edge(from, to));
}

void dfs(int s, int d)
{
    ans = max(ans, d);
    for (int i = 0; i < (int)G[s].size(); ++i)
    {
        int it = G[s][i];
        if (vis[it])
            continue;
        vis[it] = true;
        Edge &e = E[it];
        dfs(s ^ e.from ^ e.to, d + 1);
        vis[it] = false;
    }
}

int main()
{
    cin.tie(NULL);
    cout.tie(NULL);
    ios_base::sync_with_stdio(false);
    int n, m;
    while (cin >> n >> m, n || m)
    {
        init();
        for (int i = 0, x, y; i < m; i++)
        {
            cin >> x >> y;
            add_Edge(x, y);
        }
        ans = 0;
        for (int i = 0; i < n; i++)
        {
            memset(vis, 0, sizeof(vis));
            dfs(i, 0);
        }
        cout << ans << '\n';
    }
}
```