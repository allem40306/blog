---
title: Codeforces 1293 (Round 614 Div.2)
abbrlink: e5a7
date: 2020-02-03 10:14:33
category: Codeforces
tags:
- Codeforces
- dp
- math
- map
- stl
- greedy
---
這場比賽有 Div.1 和 Div.2 我選擇了 Div.2 來打(自己實力還沒那麼強)，用 virtual 過了前三題，卡在第四題，賽後把六題全解出來了。
<!-- more -->
* [A. ConneR and the A.R.C. Markland-N](https://codeforces.com/contest/1293/problem/A)
題意：$n$ 層樓的建築，你在第 $s$ 層，有 $k$ 層樓商店關閉，問最近之距離為和
題解：用 `map` 將關閉的樓層記錄起來，之後查詢 $s$ 層上下 $0,1,2...$ 樓有沒有開，即能找到答案

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int t, n, s, k;
    set<int> st;
    cin >> t;
    while(t--)
    {
        st.clear();
        cin >> n >> s >> k;
        for (int i = 0, x; i != k; ++i)
        {
            cin >> x;
            st.insert(x);
        }
        for (int i = 0; s + i <= n || s - i > 0; ++i)
        {
            if(s + i <= n && st.count(s + i) == 0)
            {
                cout << i << '\n';
                break;
            }
            if(s - i > 0 && st.count(s - i) == 0)
            {
                cout << i << '\n';
                break;
            }
        }
    }
}
```

* [B. JOE is on TV!](https://codeforces.com/contest/1293/problem/B)
題意：現在 JOE 跟 $n$ 個人比益智問答，如果某輪有 $s$ 人作答， $t$ 人淘汰，JOE 可以獲得 $\frac{t}{s}$ 獎金，問最多 JOE 可以得到多少獎金
題解：最佳的狀況是每輪都淘汰 $1$ 人，所以答案為$\frac{1}{n}+\frac{1}{n-1}+\frac{1}{n-2}+...+\frac{1}{1}$，複雜度為 $O(n)$

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n;
    double ans = 0;
    cin >> n;
    while(n != 1)
    {
        ans += 1 / double(n);
        n -= 1;
    }
    cout << ans + 1 << '\n';
}
```

* [C. NEKO's Maze Game](https://codeforces.com/contest/1293/problem/C)
題意：現在有 $2\times N$ 的方格，現在每次會讓一個點在可以走和不能走的狀態切換，每切換一點的狀態，要輸出是否能從 $(1,1)$ 走到 $(2, n)$(只能上下走右走)。
題解：模擬，用 `isup` 紀錄該格現在能不能走，`isblocked` 紀錄是否有阻擋，`notOKCnt` 紀錄現在有幾個地方有阻擋，每更新一個點 `(x,y)`，我都會查看 `(3-x, y-1)`,`(3-x, y)`,`(3-x, y+1)`的狀態，來檢查是否阻擋的地方有增減。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
const int MXN = 100005;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, q;
    bitset<MXN> isup[3], isblocked[3];
    for (int i = 0; i < 3; ++i)
    {
        isup[i].reset();
        isblocked[i].reset();
    }
    cin >> n >> q;
    int notOKCnt = 0;
    for (int i = 0, r, c, rr; i != q; ++i)
    {
        cin >> r >> c;
        rr = 3 - r;
        if(isup[r][c])
        {
            if(isup[rr][c - 1] && isblocked[rr][c - 1])
            {
                isblocked[rr][c - 1] = false;
                --notOKCnt;
            }
            if(isup[rr][c + 1] && isblocked[r][c])
            {
                isblocked[r][c] = false;
                --notOKCnt;
            }
            if(isup[rr][c] && isblocked[0][c])
            {
                isblocked[0][c] = false;
                --notOKCnt;
            }
        }
        else
        {
            if(isup[rr][c - 1] && !isblocked[rr][c - 1])
            {
                isblocked[rr][c - 1] = true;
                ++notOKCnt;
            }
            if(isup[rr][c + 1] && !isblocked[r][c])
            {
                isblocked[r][c] = true;
                ++notOKCnt;
            }
            if(isup[rr][c] && !isblocked[0][c])
            {
                isblocked[0][c] = true;
                ++notOKCnt;
            }
        }
        isup[r][c] = !isup[r][c];
        // cout << notOKCnt << '\n';
        if(notOKCnt == 0)
        {
            cout << "Yes\n";
        }
        else
        {
            cout << "No\n";
        }
    }
}
```

* [D. Aroma's Search](https://codeforces.com/contest/1293/problem/D)
題意：現在有一系列的座標，第 $0$ 個點在 $(x_0,y_0)$，第 $i(i>0)$ 個點在 $(a_xx_i−1+b_x,a_yy_i−1+b_y)$，現在在 $p_s(x_s,y_s)$，問在 $t$ 秒內能去多少，每秒可以移動一個 $x$ 單位或 $y$ 單位。
題解：因為 $t\leq 10^6$，又 $a_x,b_x\geq 2$，所以可以先把 $x,y\leq 10^6$ 的點都找出來，接著枚舉區間 $(p_L,p_R)$，我們把 $x, y$ 軸皆為遞增，所以要走遍 $(p_L,p_R)$ 至少需花 $|p_R-p_L|+min(|p_s-p_L|,|p_R-p_s|)$ 時間，只要得出一組可在 $t$ 單位內走完，並且個數比當前答案多，舊更新答案。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const LL INF = 2e16;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

LL dis(PLL a, PLL b)
{
    return abs(a.first - b.first) + abs(a.second - b.second);
}

int main()
{
    IOS;
    LL x, y, ax, ay, bx, by;
    LL xs, ys, t;
    vector<PLL> p;
    cin >> x >> y >> ax >> ay >> bx >> by;
    p.push_back({x, y});
    while(x <= INF && y <= INF)
    {
        x = ax * x + bx;
        y = ay * y + by;
        p.push_back({x, y});
    }
    cin >> xs >> ys >> t;
    PLL loc = make_pair(xs, ys);
    int ans = 0;
    for(int i = 0; i < (int)p.size(); ++i)
    {
        for(int j = i; j < (int)p.size(); ++j)
        {
            LL dL = dis(loc, p[i]);
            LL dR = dis(loc, p[j]);
            LL d = dis(p[i], p[j]);
            if(d + dL <= t || d + dR <= t)
            {
                ans = max(ans, j - i + 1);
            }
        }
    }
    cout << ans << '\n';
}
```

* [E. Xenon's Attack on the Gangs](https://codeforces.com/contest/1293/problem/E)
題意：給你一棵樹有 $n$ 個點，要在邊上依序編號上 $1$ 到 $n-1$，問 $S$ 最大為多少， $S=\Sigma_{1\leq u\leq v\leq n}mex(u,v)$，$mex(u,v)$ 為路徑 $u$ 到 $v$ 上所有數字取 $mex$ (SG Value 的 $mex$)
題解：$S=\Sigma_{1\leq u\leq v\leq n}mex(u,v)=\Sigma_{1\leq x\leq n}(\Sigma_{mex(u,v)=x}x)=\Sigma_{1\leq x\leq n}(\Sigma_{mex(u,v)\geq x}1)$，也就是說只要路徑上包含 $0$ 到 $x-1$，$(\Sigma_{mex(u,v)\geq x}1)$ 就會對 $S$ 加上 1，換句話說，如果想要讓 $S$ 越大，一條有 $L$ 條邊的路徑應該要包含 $0$ 到 $L-1$ 才行，並且越小的數字應該要在越中間。
這樣我們可以 DP 來解決，令 $dp[u][v]$ 為從 $u$ 到 $v$ 的路徑，分別填上 $0$ 到 $L-1$($L$ 為路徑經過的邊數)，所能形成最大的 $S$，$par[r][u]$ 為以 $r$ 為根 $u$ 的父親，$sub[r][u]$ 為以 $r$ 為根 $u$ 的子孫個數。$dp[u][v]$ 可由 $dp[par[v][u]][v]$ 或 $dp[u][par[u][v]]$ 更新而來，即為 $dp[u][v]=max(sub[u][v]\times sub[v][u] + dp[par[v][u]][v],sub[u][v]\times sub[v][u] + dp[u][par[u][v]])=sub[u][v]\times sub[v][u] + max(dp[par[v][u]][v],dp[u][par[u][v]])$，用遞迴算出 DP 答案，最後取最大的 DP 項即為答案。
參考連結：https://www.bilibili.com/video/av84326197?p=5

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
const int MXV = 3005;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
vector<int> G[MXV];
LL par[MXV][MXV], sub[MXV][MXV], dp[MXV][MXV];

void dfs(int u, int root)
{
    sub[root][u] = 1;
    for(auto v: G[u])
    {
        if(v == par[root][u])
        {
            continue;
        }
        par[root][v] = u;
        dfs(v, root);
        sub[root][u] += sub[root][v];
    }
}

LL getDp(int u, int v)
{
    if(u == v)
    {
        return 0;
    }
    if(dp[u][v] != -1)
    {
        return dp[u][v];
    }
    dp[u][v] =
        sub[u][v] * sub[v][u] + max(getDp(v, par[v][u]), getDp(par[u][v], u));
    return dp[u][v];
}

int main()
{
    IOS;
    int n;
    cin >> n;
    for(int i = 1, u, v; i < n; ++i)
    {
        cin >> u >> v;
        G[u].push_back(v);
        G[v].push_back(u);
    }
    for(int i = 1; i <= n; ++i)
    {
        dfs(i, i);
    }
    LL ans = 0;
    memset(dp, -1, sizeof(dp));
    for (int i = 1; i <= n; ++i)
    {
        for (int j = 1; j <= n; ++j)
        {
            ans = max(ans, getDp(i, j));
        }
    }
    cout << ans << '\n';
}
```

* [F. Chaotic V.](https://codeforces.com/contest/1293/problem/F)
題意：有一顆無向圖，點 $x$ 會接在點 $\frac{x}{f(x)}$，$f(x)$ 為 $x$ 最小質因數，現在第 $i$ 樣物品在點 $k_i!$ 上，要選一個點 $P$ 使得所有物品到該點的距離最小。1
題解：一開始設點 $P$ 為 $1$，並將 $x!$ 質因數分解，如果兩數最大 $k$ 個質因數相同，那麼它們到第 $k$ 層後(root 是第 $0$ 層)才會分開，我們想要縮小總距離和，要往最多點的分支(最大質因數相同)走去，直到走下去反而總距離和變大時停住。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
const int MXN = 5005;
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
int primeFactorization[MXN][MXN], cnt[MXN];

void preProcess()
{
    memset(primeFactorization, 0, sizeof(primeFactorization));
    for (int i = 1; i < MXN; ++i)
    {
        for (int j = 0; j < MXN; ++j)
        {
            primeFactorization[i][j] = primeFactorization[i - 1][j];
        }
        int tmp = i;
        for (int j = 2; j * j <= tmp; ++j)
        {
            while (tmp % j == 0)
            {
                ++primeFactorization[i][j];
                tmp /= j;
            }
        }
        if (tmp != 1)
        {
            ++primeFactorization[i][tmp];
        }
    }
}

void sol(int n)
{
    vector<int> bestPrimes(MXN, 1);
    LL ans = 0, cur = 0;
    for (int i = 1; i < MXN; ++i)
    {
        if (cnt[i] == 0)
        {
            bestPrimes[i] = 1;
            continue;
        }
        for (int j = 1; j < MXN; ++j)
        {
            ans += 1LL * primeFactorization[i][j] * cnt[i];
            if (primeFactorization[i][j] != 0)
            {
                bestPrimes[i] = j;
            }
        }
    }
    cur = ans;
    while (*max_element(bestPrimes.begin(), bestPrimes.end()) > 1)
    {
        vector<int> frequency(MXN, 0);
        for (int i = 0; i < MXN; ++i)
        {
            frequency[bestPrimes[i]] += cnt[i];
            // if(cnt[i])cout << i << ' ' << cnt[i] << '\n';
        }
        int bestPrime =
            max_element(frequency.begin(), frequency.end()) - frequency.begin();
        int bestCount = frequency[bestPrime];
        if (bestCount * 2 - n <= 0 || bestPrime == 1)
        {
            break;
        }
        cur += (n - bestCount) - bestCount;
        ans = min(ans, cur);
        for (int i = 0; i < MXN; ++i)
        {
            if(bestPrimes[i] != bestPrime)
            {
                bestPrimes[i] = 1;
            }
            if(bestPrimes[i] == 1)
            {
                continue;
            }
            --primeFactorization[i][bestPrimes[i]];
            while(bestPrimes[i] > 1 && primeFactorization[i][bestPrimes[i]] == 0)
            {
                --bestPrimes[i];
            }
        }
    }
    cout << ans << '\n';
}

int main()
{
    IOS;
    int n;
    vector<int> a;
    preProcess();
    cin >> n;
    a.resize(n + 5);
    for (int i = 0, x; i < n; ++i)
    {
        cin >> x;
        ++cnt[x];
    }
    sol(n);
}
```