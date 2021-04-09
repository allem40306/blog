---
title: uva11506 Angry Programmer
abbrlink: af18
date: 2020-02-20 10:00:06
category: UVa
tags:
- UVa
- flow
- Min Cut Max Flow
---
[題目連結](https://onlinejudge.org/index.php?option=onlinejudge&Itemid=99999999&page=show_problem&category=0&problem=2501&mosmsg=Submission+received+with+ID+24587536)
題意：要把前老闆的電腦和公司主機的連結切斷，除了上述兩台電腦之外，你可以將任意一台電腦或線路破壞，問最小成本為多少
<!-- more -->
解法：這是一題最小割的裸題，要加上拆點法，把每台電腦拆成兩個點($x_in$ 和 $x_out$)，中間流量為破壞電腦的成本(前老闆的電腦和公司主機的量都設為無限大)，對於每條線路，讓兩個點的 $in$ 和對方 $out$ 相連(我當初只連一邊就 WA 了)，流量為破壞線路的成本，這樣就可用 Dinic 演算法解出最大流了。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const LL INF = 1e18;
const int MXN = 0;
const int MXV = 150;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

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
    int m, n;
    Dinic<LL> dinic;
    while(cin >> m >> n, m || n)
    {
        int s = 1, t = m + m;
        dinic.init(t, s, t);
        dinic.add_edge(s, s + m, INF);
        dinic.add_edge(t - m, t, INF);
        int x, y;
        LL c;
        FOR(i, 0, m - 2)
        {
            cin >> x >> c;
            dinic.add_edge(x, x + m, c);
        }
        FOR(i, 0, n)
        {
            cin >> x >> y >> c;
            dinic.add_edge(x + m, y, c);
            dinic.add_edge(y + m, x, c);
        }
        cout << dinic.flow() << '\n';
    }
}
```