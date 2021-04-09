---
title: POJ3804 Panic Room
abbrlink: ae2f
date: 2020-02-18 23:13:22
category: POJ
tags:
- POJ
- Flow
- Min Cut Max Flow
---
題目連結：http://poj.org/problem?id=3084
題意：有許多房間，有壞人在其中幾個房間，他們想要入侵機密房間，房間之間有門，只能有一側上鎖，問最少必須關幾道門才能防止機密房間被入侵。
<!-- more -->
解法：設一個超級源點到有壞人的房間，對於每道門的兩側 $(x, y)$，假設 $x$ 是可上鎖的一側，$C(x,y)=\infty$，代表無法防止 $x$ 的人進入 $y$ 房間，$C(y,x)=1$，代表 $x$ 上鎖房間 $y$ 的人就不能進入，把機密房設為匯點，這樣一來就變成最小割的題目。
P.S. POJ 為什麼不升級編譯器版本QQ

```cpp
#pragma GCC optimize(2)
#include <iostream>
#include <vector>
#include <cstring>
#include <queue>
using namespace std;
// using LL = long long;
// using PII = pair<int, int>;
// using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 1010;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(0);                                                          \
    cout.tie(0);                                                         \
    ios_base::sync_with_stdio(false);

template <typename T> struct Dinic
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
        // cout << u << ' ' << v << ' ' << f << '\n';
        e[u].push_back({v, f, (int)e[v].size()});
        e[v].push_back({u, 0, (int)e[u].size() - 1});
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
            for (int i = 0; i < (int)e[u].size(); ++i)
            {
                Edge it = e[u][i];
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
        // cout << u << ' ' << limit << '\n';
        if (u == t)
        {
            return limit;
        }
        T res = 0;
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
            do
            {
                tmp = dfs(s, INF);
                res += tmp;
            } while (tmp);
        }
        return res;
    }
};

int main()
{
    IOS;
    int t, n, m;
    Dinic<int> dinic;
    cin >> t;
    while (t--)
    {
        cin >> m >> n;
        int ss = m, tt = n;
        dinic.init(m, ss, tt);
        string s;
        int x, y;
        FOR(i, 0, m)
        {
            cin >> s;
            if (s[0] == 'I')
            {
                dinic.add_edge(ss, i, INF);
            }
            cin >> x;
            FOR(j, 0, x)
            {
                cin >> y;
                dinic.add_edge(i, y, INF);
                dinic.add_edge(y, i, 1);
            }
        }
        int res = dinic.flow();
        if (res >= INF)
        {
            cout << "PANIC ROOM BREACH\n";
        }
        else
        {
            cout << res << '\n';
        }
    }
}
```

參考連結：https://www.shuzhiduo.com/A/A2dmGD4OJe/