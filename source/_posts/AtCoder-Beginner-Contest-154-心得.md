---
title: AtCoder Beginner Contest 154 心得
abbrlink: '8e15'
date: 2020-02-12 17:07:05
category: AtCoder
tags:
- AtCoder
- Set
- DP
- 數位 DP
- Math
- 模逆元
- Combinatorics 排列組合
---
這次比賽沒有在很好的狀態比賽，virtual 賽內對 4 題，賽後解出後 2 題。
<!-- more -->
* [A. Remaining Balls](https://atcoder.jp/contests/abc154/tasks/abc154_a)
題意：有 $S$ 和 $T$ 兩堆球，$U$ ($U=S$ or $U=T$)要從其中一堆拿球，問拿完球個數
解法：比較 $U$ 是 $S$ 還是 $T$ 在做出相對應的輸出

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
    string s, t, u;
    int m, n;
    cin >> s >> t >> m >> n >> u;
    if(s == u)
    {
        cout << m - 1 << ' ' << n << '\n';
    }
    else
    {
        cout << m << ' ' << n - 1 << '\n';
    }
}
```

* [B. I miss you...](https://atcoder.jp/contests/abc154/tasks/abc154_b)
題意：將字串中每個字都取代為 `x`
解法：算出字串長度，輸出相對應的 `x` 個數

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
    string s;
    cin >> s;
    FOR(i, 0, s.size()){cout << 'x';}
    cout << '\n';
}
```

* [C. Distinct or Not](https://atcoder.jp/contests/abc154/tasks/abc154_c)
題意：給定 $N$ 個數，問是否都不相同
解法：把數字都丟進 `set`，最後判斷 `set` 的 size 是否等於 $N$，如果不同代表有重複的

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
    set<LL> tb;
    IOS;
    int n;
    LL x;
    cin >> n;
    FOR(i, 0, n)
    {
        cin >> x;
        tb.insert(x);
    }
    if((int)tb.size() == n)
    {
        cout << "YES\n";
    }
    else
    {
        cout << "NO\n";
    }
}
```

* [D. Dice in Line](https://atcoder.jp/contests/abc154/tasks/abc154_d)
題意：有 $N$ 顆骰子排成一列，第 $i$ 顆骰子有 1 到 $p_i$，每面骰到的機率是一樣的，要你選連續 $K$ 顆獨立骰的骰子，使得期望值總和最大
解法：每顆骰子期望值為 $\frac{(1+p_i)}{2}$，把期望值做前綴和，再枚舉每個區間做計算取最大值就可得到答案。這題我沒輸出到後 8 位時會 WA，算是大發現(?

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
    int n, k;
    double ans = 0;
    cin >> n >> k;
    vector<double> v(n + 1, 0);
    FOR(i, 1, n + 1)
    {
        cin >> v[i];
        v[i] = (1 + v[i]) * 0.5;
        v[i] += v[i - 1];
    }
    FOR(i, k, n + 1)
    {
        ans = max(ans, v[i] - v[i - k]);
    }
    cout << fixed << setprecision(8) << (double)ans << '\n';
}
```

* [E. Almost Everywhere Zero](https://atcoder.jp/contests/abc154/tasks/abc154_e)
題意：問 $1$ 到 $N$ 中，有幾個數恰好有 $K$ 個非 $0$ 的位數
解法：數位dp，另 `dp[i][j][k]` 為 $N$ 的前 $i$ 位數中，有 $j$ 位非 $0$ 的位數，$k=0$ 代表前 $i$ 位剛好是 $N$ 的前 $i$ 位的狀況，$k=1$ 則為至少一位數小於 $N$ 的相對位數的狀況，轉移從前 $i$ 位轉移到前 $i+1$ 位。

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

int dp[105][4][2];
// dp[i][j][k] i digit(s), j non-zero digit(s), k = 0 ok, k = 1 not yet

int main()
{
    IOS;
    string s;
    int n, K;
    cin >> s >> K;
    n = (int)s.size();
    dp[0][0][0] = 1;
    FOR(i, 0, n) FOR(j, 0, 4) FOR(k, 0, 2)
    {
        int nd = (s[i] - '0');
        FOR(d, 0, 10)
        {
            int ni = i + 1, nj = j, nk = k;
            if (d != 0)
            {
                ++nj;
            }
            if (nj > K)
            {
                continue;
            }
            if(k == 0)
            {
                if(d > nd)
                {
                    continue;
                }
                if(d < nd)
                {
                    nk = 1;
                }
            }
            dp[ni][nj][nk] += dp[i][j][k];
            // cout << ni << ' ' << nj << ' ' << nk << ' ' << dp[ni][nj][nk] << '\n';
        }
    }
    int ans = dp[n][K][0] + dp[n][K][1];
    cout << ans << '\n';
}
```

* [F. Many Many Paths](https://atcoder.jp/contests/abc154/tasks/abc154_f)
題意：設 $F(i,j)$ 為方格中從 $(0,0)$ 藉由增加 $1$ 單位的 $x$ 或 $y$ 走到 $(i,j)$ 的辦法，求 $\Sigma_{i=r1}^{r2}\Sigma_{j=c1}^{c2}f(i,j)$
解法：要解題需要知道兩件事情。第一，二維區間 $a[][]$ 和可先求前綴和，使得 $\Sigma_{i=0}^{x}\Sigma_{j=0}^{y} a_{ij}=sum(x,y)$，任何一塊二維區間都能在 $O(1)$ 時間內求出。
第二點是 $f(0, c)+f(1, c)+f(2, c)+...+f(r, c)=C(c,0)+C(c+1,1)+C(c+2,2)+...+C(c+r,c)$$=C(c+1,0)+C(c+1,1)+C(c+2,2)+...+C(c+r,c)=C(c+r+1,c)=f(r+1,c)$，同樣道理可得出 $f(r,0)+f(r,1)+f(r,2)+...+f(r,c)=f(r,c+1)$，那麼 $\Sigma_{i=0}^{r}\Sigma_{j=0}^{c}f(i,j)=\Sigma_{i=0}^{r}f(i+1,c)=f(r+1,c+1)=C(r+c+2,c+1)$。
有了上述兩點，我們讓 $G(x,y)=C(x+y+2,x+1)-1$(1 是 $(0,0)$ 到 $(0,0)$ 的方法數)，那麼 $\Sigma_{i=r1}^{r2}\Sigma_{j=c1}^{c2}f(i,j)=G(r2,c2)-G(r1-1,c2)-G(r2,c1-1)+G(r1-1,c1-1)$ ，即為答案。
剩下的就是要利用模逆元來解題了。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 2e6 + 5;
const int MXV = 0;
const int MOD = 1e9 + 7;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
LL comb[MXN], invcomb[MXN];
 
LL extgcd(LL a, LL b, LL &x, LL &y)
{
    LL d = a;
    if (b)
    {
        d = extgcd(b, a % b, y, x), y -= (a / b) * x;
    }
    else
        x = 1, y = 0;
    return d;
} // ax+by=1 ax同餘 1 mod b
 
LL inv(LL a)
{
    LL x, y, b = MOD;
    extgcd(a, b, x, y);
    while(x >= MOD)
    {
        x -= MOD;
    }
    while(x < 0)
    {
        x += MOD;
    }
    return x;
}
 
void pre()
{
    comb[0] = 1;
    invcomb[0] = 1;
    for(int i = 1; i < MXN; ++i)
    {
        comb[i] = (comb[i - 1] * i) % MOD;
        invcomb[i] = inv(comb[i]);
    }
}
 
LL choose(int m, int n)
{
    LL ans = comb[m];
    ans = (ans * invcomb[m - n]) % MOD;
    ans = (ans * invcomb[n]) % MOD;
    return ans;
}

LL G(int m, int n) { return choose((m + 1) + (n + 1), n + 1) - 1; }

int main()
{
    IOS;
    pre();

    int r1, r2, c1, c2;
    cin >> r1 >> c1 >> r2 >> c2;
    --r1;
    --c1;

    LL ans = G(r2, c2) - G(r2, c1) - G(r1, c2) + G(r1, c1);
    while(ans <= 0)
    {
        ans += MOD;
    }
    ans %= MOD;
    cout << ans << '\n';
}
```
