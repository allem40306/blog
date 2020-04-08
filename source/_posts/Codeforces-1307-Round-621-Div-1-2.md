---
title: Codeforces 1307 Round 621 Div.1+2
abbrlink: 5a0c
date: 2020-04-05 17:01:36
category: Codeforces
tags:
- greedy
- dp
- graph
- 最短路徑
- bfs
- 差值排序
- math
- combinatorics
---
這場我打了前五題，第六題看了很久，都不了解，發現自己功力不夠就止住了。
<!-- more -->
* [A. Cow and Haybales](https://codeforces.com/contest/1307/problem/A)
題意：有 $N$ 個稻草堆，第 $i$ 個稻草堆有 $A_i$ 捆，每天可以選一捆稻草移從第 $i$ 堆移到第 $i-1$ 堆，問 $D$ 天後第 $1$ 堆最多會有幾個。
題解：貪心策略，從第 $2$ 堆的稻草開始移，如果移完再移第 $3$ 堆的，依此類推。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
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

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int n, d;
        cin >> n >> d;
        vector<int> v(n);
        FOR(i, 0, n) { cin >> v[i]; }
        FOR(i, 1, n)
        {
            if (v[i] == 0)
            {
                continue;
            }
            int tmp = min(d / i, v[i]);
            v[0] += tmp;
            d -= tmp * i;
        }
        cout << v[0] << '\n';
    }
}
```

* [B. Cow and Friend](https://codeforces.com/contest/1307/problem/B)
題意：現在在二維空間要從 $(0,0)$ 走到 $(x,0)$，有 $N$ 種不同距離的步伐可以走，問最少要走幾步。
題解：一樣是貪心策略，利用最大的步伐走(至少兩步)，但如果有距離為 $x$ 的走法，就只要一步。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
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

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int n, x;
        bool hasEqual = false;
        cin >> n >> x;
        vector<int> v(n);
        FOR(i, 0, n)
        {
            cin >> v[i];
            if (v[i] == x)
            {
                hasEqual = true;
            }
        }
        int mx = *max_element(v.begin(), v.end());
        if (hasEqual)
        {
            cout << 1 << '\n';
        }
        else
        {
            cout << max((x / mx) + 1 * (x % mx != 0), 2) << '\n';
        }
    }
}
```

* [C. Cow and Message](https://codeforces.com/contest/1307/problem/C)
題意：給定一個字串 $S$，要求出現最多次的 subsequence 的次數。
題解：一定有答案長度為 $1$ 和 $2$，因為如果有超過 $2$ 的答案，必有相對長度為 $\leq 2$ 的答案。利用 `dp` 計算長度為 $1$ 和 $2$ 出現的次數。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<LL>;
using VVI = vector<VI>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
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

int main()
{
    IOS;
    string s;
    cin >> s;
    int n = (int)s.size();
    VI dp(30, 0);
    VVI dp2(30, VI(30, 0));
    FOR(i, 0, n)
    {
        int no = (int)(s[i] - 'a');
        FOR(j, 0, 30) { dp2[j][no] += dp[j]; }
        ++dp[no];
    }
    LL ans = 0;
    FOR(i, 0, 30)
    {
        FOR(j, 0, 30) { ans = max(ans, dp2[i][j]); }
        ans = max(ans, dp[i]);
    }
    cout << ans << '\n';
}
```

* [D. Cow and Fields](https://codeforces.com/contest/1307/problem/D)
題意：給一張 $N$ 個點，$M$ 條邊的圖，在"要從 $K$ 個給定的點集 $A$ 中，選兩個點連成一條邊"的情況下，問 $1$ 到 $n$ 的最短距離最大可以是多少。
題解：設原圖中，$d1_{s}=d(1,s),d2_{s}=d(n,s)$，最短路有兩種可能，一種為 $d1_{n}=d2_{1}$，一種是 $d1_{x}+1+d2_{y},(x,y\in A)$，第一種可由 BFS 或最短路演算法算出，第二種需最大化 $min(d1_{x}+d2_{y}, d1_{y}+d2_{x})$，$d1_{x}+d2_{y}\leq d1_{y}+d2_{x}\to d1_{x}-d2_{x}\leq d1_{y}-d2_{y}$，我們依照 $d1_{x}-d2_{x}$ 排列，在依序迭代 $A$ 找尋最大值，最後和第一種方法取最小值。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
using VVI = vector<VI>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 2e5 + 5;
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

VVI G(MXV, VI(0, 0));

struct Dijkstra
{
    void init(int n)
    {
        for (int i = 0; i <= n; ++i)
        {
            G[i].clear();
        }
    }

    void addEdge(int from, int to)
    {
        G[from].push_back(to);
        G[to].push_back(from);
    }

    void dijkstra(VI &d, int s)
    {
        d[s] = 0;
        queue<int> q;
        q.push(s);
        while (!q.empty())
        {
            int u = q.front();
            q.pop();
            for (int v : G[u])
            {
                if (d[v] != -1)
                {
                    continue;
                }
                d[v] = d[u] + 1;
                q.push(v);
            }
        }
    }
};

VI d1(MXV, -1), d2(MXV, -1);
bool cmp(int x, int y) { return d1[x] - d2[x] < d1[y] - d2[y]; };

int main()
{
    IOS;
    int n, m, k;
    Dijkstra dijkstra;
    cin >> n >> m >> k;
    dijkstra.init(n);
    VI p(k);
    FOR(i, 0, k) { cin >> p[i]; }
    FOR(i, 0, m)
    {
        int x, y;
        cin >> x >> y;
        dijkstra.addEdge(x, y);
    }
    dijkstra.dijkstra(d1, 1);
    dijkstra.dijkstra(d2, n);
    // FOR(i, 1, n + 1) { cout << d1[i] << ' ' << d2[i] << '\n'; }
    sort(p.begin(), p.end(), cmp);
    int ans = 0, tmp = -1e9;
    FOR(i, 0, k)
    {
        int v = p[i];
        ans = max(ans, tmp + d2[v] + 1);
        tmp = max(tmp, d1[v]);
    }
    ans = min(ans, d1[n]);
    cout << ans << '\n';
}
```

* [E. Cow and Treats](https://codeforces.com/contest/1307/problem/E)
題意：現在有 $N$ 塊草地，有各自的口味 $S_i$，有 $M$ 隻羊，第 $i$ 隻羊要吃 $h_i$ 塊口味為 $f_i$ 的草地，羊從兩邊出發，遇到自己喜歡的口味就吃，在不能碰到彼此的狀況，最多可以讓幾隻羊滿足及該結果方法數有幾種。
題解：首先，吃同口味的羊一邊只能有一隻，如果兩隻肯定會遇到。我們可以枚舉兩群羊的邊界來計算答案，細節的我還沒搞清楚，就先貼上[參考連結](https://blog.csdn.net/weixin_44282912/article/details/104738446)。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
using VLL = vector<LL>;
using VVI = vector<VI>;
using VVLL = vector<VLL>;
const int INF = 1e9;
const int MXN = 5005;
const int MXV = 0;
const LL MOD = 1e9 + 7;
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

int main()
{
    IOS;
    int n, m;
    cin >> n >> m;
    VI s(n + 1);
    // lsum[x]: each j<=i and c[j]=x
    // rsum[x]: each j>i and c[j]=x
    VLL lsum(n + 1, 0), rsum(n + 1, 0);
    VVLL num(n + 1, VLL(n + 1, 0));
    FOR(i, 1, n + 1)
    {
        cin >> s[i];
        ++rsum[s[i]];
    }
    FOR(i, 1, m + 1)
    {
        int f, h;
        cin >> f >> h;
        FOR(j, h, n + 1) { ++num[f][j]; }
    }
    PLL ans = MP(0, 0);
    FOR(i, 0, n + 1)
    {
        int x = s[i];
        if (i)
        {
            ++lsum[x];
            --rsum[x];
        }
        LL ls = lsum[x], rs = rsum[x];
        PLL tmp = MP(0, 1);
        if (i)
        {
            LL cnt1 = num[x][ls] - num[x][ls - 1];
            if (cnt1 == 0)
            {
                continue;
            }
            LL cnt2 = num[x][rs] - (ls <= rs);
            ++tmp.F;
            tmp.S = (tmp.S * cnt1) % MOD;
            if (cnt2)
            {
                ++tmp.F;
                tmp.S = (tmp.S * cnt2) % MOD;
            }
        }
        FOR(x2, 1, n + 1)
        {
            if (x == x2)
            {
                continue;
            }
            LL cnt1 = num[x2][lsum[x2]];
            LL cnt2 = num[x2][rsum[x2]];
            if (cnt1 > cnt2)
            {
                swap(cnt1, cnt2);
            }
            if (cnt2)
            {
                ++tmp.F;
                if (cnt1 == 0)
                {
                    tmp.S = tmp.S * cnt2 % MOD;
                }
                else if (cnt2 == 1)
                {
                    tmp.S = tmp.S * 2LL % MOD;
                }
                else
                {
                    ++tmp.F;
                    tmp.S = (tmp.S * cnt1) % MOD * (cnt2 - 1) % MOD;
                }
            }
        }
        if (ans.F < tmp.F)
        {
            ans = tmp;
        }
        else if (tmp.F == ans.F)
        {
            ans.S = (ans.S + tmp.S) % MOD;
        }
    }
    cout << ans.F << ' ' << ans.S << '\n';
}
```