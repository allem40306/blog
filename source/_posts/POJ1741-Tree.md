---
title: POJ1741 Tree
category: POJ
tags:
  - POJ
  - 重心分治
abbrlink: f737
date: 2019-08-05 16:41:41
---
http://poj.org/problem?id=1741
http://sunmoon-coding.blogspot.com/2017/03/poj-1741-tree.html
這題給一個樹，邊上有權重，求有多少條路徑權重和`<=k`。
<!-- more -->
這題解法是在樹上做重心分治，先求出整棵樹的答案，扣除每個子樹各自的答案，在遞迴到各子樹去求各自的答案，因為是把重心拿來當根，所以最多只有`log V`層，算出路徑數(`calc`)需要`O(VlogV)`，整體複雜度為`O(V(log V)^2)`。

{% codeblock lang:cpp %}
#include <iostream>
#include <vector>
#include <utility>
#include <bitset>
#include <algorithm>
#include <ctime>
using namespace std;
typedef pair<int, int> PII;
const int INF = 200000000;
const int MXN = 10005;
int n, k;
int treeSz[MXN];
vector<PII> G[MXN];
bitset<MXN> vis;

void init(int n)
{
    vis.reset();
    for(int i = 0; i <= n; ++i)
    {
        G[i].clear();
    }
    for(int i = 0, x, y, z; i < n - 1; ++i)
    {
        cin >> x >> y >> z;
        G[x].push_back(make_pair(y, z));
        G[y].push_back(make_pair(x, z));
    }
}

vector<int> dis;

void getDis(int u, int f, int d)
{
    dis.push_back(d);
    for(size_t i = 0; i != G[u].size(); ++i)
    {
        PII &e = G[u][i];
        int v = e.first, w = e.second;
        if(v != f && !vis[v])
        {
            getDis(v, u, d + w);
        }
    }
}

int calc(int u, int d)
{
    dis.clear();
    getDis(u, -1, d);
    sort(dis.begin(), dis.end());
    int L = 0, R = dis.size() - 1, res = 0;
    while(L < R)
    {
        while(L < R && dis[L] + dis[R] > k)
        {
            --R;
        }
        res += (R - L);
        ++L;
    }
    return res;
}

PII treeCentroid(int u, int f, int sz)
{
    // cout << u << ' ' << f << ' ' << sz << '\n';
    treeSz[u] = 1;
    PII res(__INT_MAX__, -1);
    int mx = 0;
    for(size_t i = 0; i != G[u].size(); ++i)
    {
        PII &e = G[u][i];
        int v = e.first;
        if(v == f || vis[v] == true)
        {
            continue;
        }
        res = min(res, treeCentroid(v, u, sz));
        // cout << u << ' ' << res.first << ' '<< res.second << '\n';
        treeSz[u] += treeSz[v];
        mx = max(mx, treeSz[v]);
    }
    mx = max(mx, sz - treeSz[u]);
    // cout << u << ':' << mx << ' ' << u << '\n';
    return min(res, {mx, u});
}

int treeDC(int u, int sz)
{
    int center = treeCentroid(u, -1, sz).second;
    int ans = calc(center, 0);
    vis[center] = 1;
    for(size_t i = 0; i != G[center].size(); ++i)
    {
        PII &e = G[center][i];
        int v = e.first, w = e.second;
        if(vis[v])
        {
            continue;
        }
        ans -= calc(v, w);
        if(treeSz[v] > treeSz[center])
        {
            treeSz[v] = sz - treeSz[center];
        }
        ans += treeDC(v, treeSz[v]);
    }
    return ans;
}

int main()
{
    cin.tie(NULL);
    ios_base::sync_with_stdio(false);
    
    while(cin >> n >> k, n || k)
    {
        init(n);
        cout << treeDC(1, n) << '\n';
    }
}
{% endcodeblock %}