---
title: uva01212 Duopoly
abbrlink: ef7b
date: 2020-02-17 13:05:03
category: UVa
tags:
- UVa
- flow
- Min Cut Max Flow
---
連結：https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&category=0&problem=3653&mosmsg=Submission+received+with+ID+24572964
題意：政府有若干頻道，有兩家公司有多個申請計畫，每個計畫包含支付政府的金額及數個會占用的頻道，一個頻道政府只能給一家公司使用，問最佳狀況下，政府最大利益為何?
<!-- more -->
解法：把題目換一個講法，政府最小需要放棄多少計畫的金額，將一源點連到公司 A 的的計畫，容量為支付金額，公司 B 的的計畫也連到一匯點，容量亦為支付金額，兩公司有衝突項目的計畫中間連一條從 A 公司計畫的 B 公司計畫的無限大容量的匯點，這樣就變成最小割的題目，即為找出要放棄多少計畫的最低金額。我中途卡過 WA 原因是我 `add_edge` 用的是無向圖的版本，這題應為有向圖才對。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const LL INF = 0x3f3f3f3f;
const int MXN = 300005;
const int MXV = 6010;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);

struct Bid
{
    LL val;
    vector<int> cha;
    void init(LL _val)
    {
        val = _val;
        cha.clear();
    }
} bidA[MXV], bidB[MXV];

int toBid[MXN];

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
    int T, tc = 0;
    Dinic<LL> dinic;
    cin >> T;
    while (T--)
    {
        int m, n, cha;
        LL val, sum = 0;
        string str;
        cin >> n >> ws;
        memset(toBid, -1, sizeof(toBid));
        FOR(i, 1, n + 1)
        {
            getline(cin, str);
            stringstream ss(str);
            ss >> val;
            sum += val;
            bidA[i].init(val);
            while (ss >> cha)
            {
                bidA[i].cha.push_back(cha);
                toBid[cha] = i;
            }
        }
        cin >> m >> ws;
        FOR(i, 1, m + 1)
        {
            getline(cin, str);
            stringstream ss(str);
            ss >> val;
            sum += val;
            bidB[i].init(val);
            while (ss >> cha)
            {
                bidB[i].cha.push_back(cha);
            }
        }
        int s = 0, t = m + n + 2;
        dinic.init(t, s, t);
        FOR(i, 1, n + 1) { dinic.add_edge(s, i, bidA[i].val); }
        FOR(i, 1, m + 1) { dinic.add_edge(n + i, t, bidB[i].val); }
        FOR(i, 1, m + 1)
        {
            for (int cha : bidB[i].cha)
            {
                if (toBid[cha] != -1)
                {
                    dinic.add_edge(toBid[cha], n + i, INF);
                }
            }
        }
        if (tc)
        {
            cout << '\n';
        }
        ++tc;
        cout << "Case " << tc << ":\n";
        cout << sum - dinic.flow() << '\n';
    }
}
```

相關連結：https://blog.csdn.net/llx523113241/article/details/47376039