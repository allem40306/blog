---
title: uva10480 Sabotage
abbrlink: a5f4
date: 2020-02-16 15:04:53
category: UVa
tags:
- UVa
- Flow
- Min Cut Max Flow
---
連結：https://onlinejudge.org/index.php?option=onlinejudge&Itemid=99999999&page=show_problem&category=0&problem=1421&mosmsg=Submission+received+with+ID+24569393
題意：一個國家有 $N$ 個都市和 $M$ 條道路，現在要讓 $1$ 號城市(首都)到 $2$ 號城市(最大的城市)無法連通，炸掉每條路有不同的成本，問要炸到哪幾條路有最低的成本。
<!-- more -->
解法：這題是 Min Cut(最小割)的題目，可以轉成最大流來做。這題問的是哪幾條是最小割，需要根據最後一次 BFS 的結果找出來，一條邊在最小割裡的條件是，只有一端點連到起點，並且該條邊流量已達上限。所以枚舉每條邊看合不合規定就可以得出答案。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 505;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

template <typename T>
struct Dinic
{
    int n, s, t, level[MXV], now[MXV];
    struct Edge
    {
        int v;
        T rf; // rf: residual flow
        int re;
    };
    vector<Edge> e[MXV];
    void init(int _n, int _s, int _t)
    {
        n = _n;
        s = _s;
        t = _t;
        for (int i = 0; i <= n; i++)
        {
            e[i].clear();
        }
    }
    void add_edge(int u, int v, T f)
    {
        e[u].push_back({v, f, (int)e[v].size()});
        e[v].push_back({u, f, (int)e[u].size() - 1});
    }
    bool bfs()
    {
        fill(level, level + n + 1, -1);
        queue<int> q;
        q.push(s);
        level[s] = 0;
        while (!q.empty())
        {
            int u = q.front();
            q.pop();
            for (auto it : e[u])
            {
                if (it.rf > 0 && level[it.v] == -1)
                {
                    level[it.v] = level[u] + 1;
                    q.push(it.v);
                }
            }
        }
        return level[t] != -1;
    }
    T dfs(int u, T limit)
    {
        if (u == t)
            return limit;
        int res = 0;
        while (now[u] < (int)e[u].size())
        {
            Edge &it = e[u][now[u]];
            if (it.rf > 0 && level[it.v] == level[u] + 1)
            {
                T f = dfs(it.v, min(limit, it.rf));
                res += f;
                limit -= f;
                it.rf -= f;
                e[it.v][it.re].rf += f;
                if (limit == 0)
                {
                    return res;
                }
            }
            else
            {
                ++now[u];
            }
        }
        if (!res)
        {
            level[u] = -1;
        }
        return res;
    }
    T flow(T res = 0)
    {
        while (bfs())
        {
            T tmp;
            memset(now, 0, sizeof(now));
            do{
                tmp = dfs(s, INF);
                res += tmp;
            }while(tmp);
        }
        // cout << res << '\n';
        return res;
    }
    void find_minimum_cut()
    {
        FOR(i, 1, n + 1)if(level[i] != -1)
        {
            for(auto edge: e[i])
            {
                if(level[edge.v] == -1 && edge.rf == 0)
                {
                    cout << i << ' ' << edge.v << '\n';
                }
            }
        }
    }
};

int main()
{
    IOS;
    int m, n;
    Dinic<LL> dinic;
    bool delimiter = false;
    while(cin >> m >> n, m || n)
    {
        if(delimiter)
        {
            cout << '\n';
        }
        delimiter = true;
        dinic.init(m, 1, 2);
        int x, y;
        LL c;
        FOR(i, 0, n)
        {
            cin >> x >> y >> c;
            dinic.add_edge(x, y, c);
        }
        dinic.flow();
        dinic.find_minimum_cut();
    }
}
```