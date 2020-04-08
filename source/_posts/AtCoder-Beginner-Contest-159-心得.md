---
title: AtCoder Beginner Contest 159 心得
abbrlink: 17d4
date: 2020-04-04 14:08:54
category: AtCoder
tags:
- 枚舉
- 二進位枚舉
- dp
- 背包 dp
---
這場大概花了 4 個小時來寫這 6 題，難度算中間偏易。
<!-- more -->
* [A - The Number of Even Pairs](https://atcoder.jp/contests/abc159/tasks/abc159_a)
題意：有 $N$ 顆偶數球和 $M$ 顆奇數球，問有幾種方法選兩顆球，使得球上數字相加為偶數。
解法：兩奇數或兩偶數相加為偶數，所以答案即為$C(N,2)+C(M,2)$

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

int f(int n)
{
    if(n < 2){
        return 0;
    }
    return n * (n - 1) / 2;
}

int main()
{
    IOS;
    int n, m;
    cin >> n >> m;
    cout << f(n) + f(m) << '\n';
}
```

* [B - String Palindrome](https://atcoder.jp/contests/abc159/tasks/abc159_b)
題意：判斷一個長度為 $N$ 的字串 $S$ 是否本身為迴文，且 $S[1:\frac{N-1}{2}]$ 和 $S[\frac{N+3}{2}:N]$ 也是迴文。
解法：直接判斷。

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

bool ok(string &s, int L, int R)
{
    while (L <= R)
    {
        if (s[L] != s[R])
        {
            return false;
        }
        ++L;
        --R;
    }
    return true;
}

int main()
{
    IOS;
    string s;
    cin >> s;
    int sz = (int)s.size();
    if (ok(s, 0, sz - 1) && ok(s, 0, (sz - 1) / 2 - 1) &&
        ok(s, (sz + 3) / 2 - 1, sz - 1))
    {
        cout << "Yes\n";
    }
    else
    {
        cout << "No\n";
    }
}
```

* [C - Maximum Volume](https://atcoder.jp/contests/abc159/tasks/abc159_c)
題意：給定一實數 $L$，求 $x_1x_2x_3$ 的最大值，其中 $x_1+x_2+x_3=L$。
解法：當 $x_1=x_2=x_3=\frac{L}{3}$ 時有最大值。

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
    double x;
    cin >> x;
    x /= 3;
    cout << fixed << setprecision(8) << x * x * x << '\n';
}
```

* [D - Banned K](https://atcoder.jp/contests/abc159/tasks/abc159_d)
題意：給定 $N$ 顆球，第 $i$ 顆球上面的數字為 $A_i$，問 $k=1,2,3,...,N$，問沒有第 $i$ 顆球時，有幾對球的數字是一樣的。
解法：我們可以先把全部的對數 $ans$ 求出來，假設數字為 $A$ 的有 $cnt[A_i]=x$ 顆，那麼會對 $ans$ 貢獻 $C(x,2)$，如果是屏除第 $i$ 顆球，那麼答案會是 $ans-C(cnt[A_i],2)+C(cnt[A_i]-1,2)$。

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

LL f(LL n)
{
    if (n < 2)
    {
        return 0;
    }
    return n * (n - 1) / 2;
}

int main()
{
    IOS;
    int n;
    cin >> n;
    LL ans = 0;
    vector<LL> a(n, 0), cnt(n + 1, 0);
    FOR(i, 0, n)
    {
        cin >> a[i];
        ++cnt[a[i]];
    }
    FOR(i, 0, n + 1) { ans += f(cnt[i]); }
    FOR(i, 0, n) { cout << ans - f(cnt[a[i]]) + f(cnt[a[i]] - 1) << '\n'; }
}
```

* [E - Dividing Chocolate](https://atcoder.jp/contests/abc159/tasks/abc159_e)
題意：有一塊巧克力是由 $H\times W$ 的小巧克力組成，有白和黑兩種顏色，可以垂直或水平切巧克力，問最小切法使得每塊巧克力最多只有 $K$ 塊白巧可力。
解法：題目給的 $H$ 最多到 $10$，可以利用二進位枚舉水平切的地方，一邊判斷是不是能夠切 $\leq K$ 塊小白巧克力，一邊計算出還要切多少垂直的刀。

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

void update(vector<int> &v, int x, int h)
{
    v.clear();
    v.push_back(0);
    int idx = 1;
    while (x)
    {
        if ((x & 1) != 0)
        {
            v.push_back(idx);
        }
        x >>= 1;
        ++idx;
    }
    v.push_back(h);
}

int main()
{
    // IOS;
    int h, w, k;
    cin >> h >> w >> k;
    VVI sum(h + 1, VI(w + 1, 0));
    FOR(i, 1, h + 1)
    {
        string s;
        cin >> s;
        FOR(j, 1, w + 1)
        {
            sum[i][j] = (int)(s[j - 1] - '0');
            sum[i][j] =
                sum[i][j] + sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1];
        }
    }
    int ans = h * w;
    vector<int> hs;
    FOR(state, 0, (1 << (h - 1)))
    {
        int cur = __builtin_popcount(state);
        bool ok = true;
        int j2 = 0;
        update(hs, state, h);
        FOR(j, 1, w + 1)
        {
            int wmax = 0;
            FOR(i, 1, hs.size())
            {
                wmax = max(wmax, sum[hs[i]][j] - sum[hs[i]][j2] -
                                     sum[hs[i - 1]][j] + sum[hs[i - 1]][j2]);
            }
            // cout << j << ' ' << wmax << '\n';
            if (wmax > k)
            {
                if (j == 1)
                {
                    ok = false;
                    break;
                }
                ++cur;
                j2 = j - 1;
            }
        }
        if (ok)
        {
            // cout << state << ' ' << cur << '\n';
            ans = min(ans, cur);
        }
    }
    cout << ans << '\n';
}
```

* [F - Knapsack for All Segments](https://atcoder.jp/contests/abc159/tasks/abc159_f)
題意：給定一個長度為 $N$ 的序列 $A$，$f(L,R)$ 為滿足以下條件的子序列數量：$A_{x_1}+A_{x_2}+A_{x_3}+...+A_{x_k}=S$ and $L\leq x_1\leq x_2\leq x_3\leq ... \leq x_k \leq R$。求 $\Sigma_{i=1}^{N}\Sigma_{j=i}^{N}f(i,j)$。
解法：我們如果發現一個 $x_1=i,x_k=j$ 的子序列滿足條件，那麼它會對 $f(i,j),f(i-1,j),f(i-2,j),...f(1,j)$ 貢獻 $1$，於是我們設一個陣列 $dp$，$dp[i]$ 代表當前和為 $i$ 的子序列數量，當有新元素($A_x$)加入時，利用背包 dp 的方式，加上之前所形成的子元素數量。再來，如果子序列以 $A_x$ 開頭，對於固定右端點 $f(i,j)(x\leq j)$ 都會貢獻 $x$，所以在 $dp[A_x]$ 加上 $x$，加完一個元素 $A_x$ 後，$dp[s]=\Sigma_{i=1}^{x}f(i,x)$，那麼把這些 $dp[s]$ 加起來就是答案了。

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
    int n, s;
    cin >> n >> s;
    vector<LL> a(n + 1, 0), dp(s + 1, 0);
    LL ans = 0;
    FOR(i, 1, n + 1) { cin >> a[i]; }
    FOR(i, 1, n + 1)
    {
        FORD(j, s, a[i] - 1) { dp[j] = (dp[j] + dp[j - a[i]]) % MOD; }
        if (a[i] <= s)
        {
            dp[a[i]] = (dp[a[i]] + i) % MOD;
        }
        ans = (ans + dp[s]) % MOD;
    }
    cout << ans << '\n';
}
```
