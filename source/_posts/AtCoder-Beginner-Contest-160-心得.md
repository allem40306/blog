---
title: AtCoder Beginner Contest 160 心得
abbrlink: 8d00
date: 2020-05-09 11:00:59
category: AtCoder
tags:
---
這場比賽是一個月前打的，之後為了趕報告和期中考，都沒有時間打程式競賽了。
<!-- more -->
* [A - Coffee](https://atcoder.jp/contests/abc160/tasks/abc160_a)
題意：給定一個長度為 6 的字串，問不是和 `coffee` 一樣，第 3 和第 4 個字相同，第 5 和第 6 個字相同。
解法：字串判斷。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
const LL MOD = 998244353;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i < (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i > (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    string s;
    cin >> s;
    if (s[2] == s[3] && s[4] == s[5])
    {
        cout << "Yes\n";
    }
    else
    {
        cout << "No\n";
    }
}
```

* [B - Golden Coins](https://atcoder.jp/contests/abc160/tasks/abc160_b)
題意：現在有 $X$ 元，可以換成 500 元硬幣得到 1000 幸福值，或是換成 5 元硬幣得到 5 幸福值，問最多可以得到多少幸福值。
解法：如果手上 $\geq$ 500 元，就換 500 元硬幣，剩下的再換 5 元硬幣。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    LL x;
    cin >> x;
    LL ans = x / 500 * 1000;
    x %= 500;
    ans += x / 5 * 5;
    cout << ans << '\n';
}
```

* [C - Traveling Salesman around Lake](https://atcoder.jp/contests/abc160/tasks/abc160_c)
題意：一個環長 $K$ 公尺，有 $N$ 間房子，第 $i$ 間在位置 $A_i$，問拜訪每間房子所需最短距離為和。
解法：拜訪 $N$ 間房子就是從第 $1$ 間房子走過 $N - 1$ 個間隔到達第 $N$ 間房間，如果是一個環狀的路，$N$ 個房間有 $N$ 個間隔，把最大間隔距離剃除後，就是最短距離。

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
    int k, n;
    cin >> k >> n;
    vector<int> v(n);
    FOR(i, 0, n) { cin >> v[i]; }
    int mx = v[0] + (k - v[n - 1]);
    FOR(i, 1, n) { mx = max(mx, v[i] - v[i - 1]); }
    cout << k - mx << '\n';
}
```

* [D - Line++](https://atcoder.jp/contests/abc160/tasks/abc160_d)
題意：有 $N$ 個點連成一條線($1\to 2\to 3\to ...\to N$)，現在在 $x$ 和 $y$ 加一條邊，要你分別求出最短距離為 $1,2,3,...,n-1$的點對有幾個。
解法：枚舉所有點對$(a,b)$，算出他們之間最短距離，有三種情形 $a\to b,a\to x\to y\to b,a\to y\to x\to b$，在這些情形中取最小值。

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
    int n, x, y;
    cin >> n >> x >> y;
    vector<int> ans(n + 1, 0);
    FOR(i, 1, n + 1)
    {
        FOR(j, i + 1, n + 1)
        {
            int mn = min({abs(i - j), abs(i - x) + abs(j - y) + 1,
                          abs(i - y) + abs(j - x) + 1});
            ++ans[mn];
        }
    }
    FOR(i, 1, n) { cout << ans[i] << "\n"; }
}
```

* [E - Red and Green Apples](https://atcoder.jp/contests/abc160/tasks/abc160_e)
題意：現在有 $A$ 顆紅蘋果，$B$ 顆綠蘋果，$C$ 顆無色蘋果，各有各的美味程度，要從中挑出 $X$ 顆紅蘋果和 $Y$ 顆綠蘋果，為最大美味程度為何，無色蘋果可以當成紅蘋果或綠蘋果。
解法：不論無色蘋果多寡，最多只能選取 $X$ 顆紅蘋果和 $Y$ 顆綠蘋果，所以就將 $X$ 顆最大美味程度的紅蘋果，最大美味程度的 $Y$ 顆綠蘋果，和所有的無色蘋果比較，選出 $X+Y$ 顆蘋果。

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
    // IOS;
    int x, y, a, b, c;
    cin >> x >> y >> a >> b >> c;
    vector<LL> R(a), G(b), C(c);
    FOR(i, 0, a) { cin >> R[i]; }
    FOR(i, 0, b) { cin >> G[i]; }
    FOR(i, 0, c) { cin >> C[i]; }
    sort(R.begin(), R.end(), greater<LL>());
    sort(G.begin(), G.end(), greater<LL>());
    FOR(i, 0, x) { C.push_back(R[i]); }
    FOR(i, 0, y) { C.push_back(G[i]); }
    sort(C.begin(), C.end(), greater<LL>());
    LL ans = 0;
    FOR(i, 0, x + y) { ans += C[i]; }
    cout << ans << '\n';
}
```

* [F - Distributing Integers](https://atcoder.jp/contests/abc160/tasks/abc160_f)
題意：給定一張有 $N$ 個點的樹，需選定一個點 $K$ 當根 填入 $1$，然後選擇一個沒數字但相鄰的點有數字的點，依序填入 $2,3,4,...,k$。問 $k=1,2,3,...,N$ 時有幾種填法。
解法：這題要利用「換根 dp」，一開始先選定一個點為根，算出所有點 $u$ 對於其子樹有幾種填法 $dp[u]$，假設點 $u$ 的子樹為$c_1,c_2,c_3,...,c_m$，那麼 $dp[u]=\Pi_{i=1}^{m}dp[c_i](\frac{sz[u]!}{\Pi_{i=1}^{m}sz[c_i]!})$。再來是換根的部分，對於 $u$ 的所有子節點 $v$ 現在要把 $u$ 變成 $v$ 的子節點，要先把 $ans[u]$ 包含 $v$ 的部分去掉，也就是要除以 $C(sz[u],sz[v])*dp[v]$，接著讓 $v$ 把 $u$ 當子節點更新 $ans[v]$，即可得到答案。
參考：https://www.woria.xyz/2020/03/28/ABC160/#F-Distributing-Integers

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
const int INF = 1e9;
const int MXN = 0;
const int MXV = 2e5 + 5;
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

VLL fac, invfac;

LL pow2(LL a, LL b)
{
    LL res = 1;
    while (b)
    {
        if ((b & 1) != 0)
        {
            res = (res * a) % MOD;
        }
        a = (a * a) % MOD;
        b >>= 1;
    }
    return res;
}

void init(int n)
{
    fac.resize(n + 1);
    invfac.resize(n + 1);
    fac[0] = 1;
    FOR(i, 1, n + 1) { fac[i] = (fac[i - 1] * i) % MOD;}
    invfac[n] = pow2(fac[n], MOD - 2);
    FORD(i, n - 1, 0 - 1) { invfac[i] = (invfac[i + 1] * (i + 1)) % MOD;}
}

int n;
VVI G;
VLL dp, sz, ans;

LL C(int m, int n) { return (fac[m] * invfac[n]) % MOD * invfac[m - n] % MOD; }

void dfs1(int u, int p)
{
    for (int v : G[u])
    {
        if (v == p)
        {
            continue;
        }
        dfs1(v, u);
        sz[u] += sz[v];
        dp[u] = (dp[u] * dp[v] % MOD) * C(sz[u] - 1, sz[v]) % MOD;
    }
}

void dfs2(int u, int p)
{
    for (int v : G[u])
    {
        if (v == p)
        {
            continue;
        }
        ans[v] = ans[u] * pow2(C(n - 1, sz[v]) * dp[v] % MOD, MOD - 2) % MOD;
        ans[v] =
            (ans[v] * dp[v] % MOD) * C(n - 1, n - sz[v]) % MOD;
        dfs2(v, u);
    }
}

int main()
{
    IOS;
    cin >> n;
    G.resize(n + 5);
    dp.resize(n + 5, 1);
    sz.resize(n + 5, 1);
    ans.resize(n + 5);
    init(n);
    FOR(i, 0, n - 1)
    {
        int a, b;
        cin >> a >> b;
        G[a].push_back(b);
        G[b].push_back(a);
    }
    dfs1(1, -1);
    // FOR(i, 1, n + 1) { cout << dp[i] << '\n'; }
    ans[1] = dp[1];
    dfs2(1, -1);
    FOR(i, 1, n + 1) { cout << ans[i] << '\n'; }
}
```