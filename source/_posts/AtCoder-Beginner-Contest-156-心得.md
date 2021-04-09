---
title: AtCoder Beginner Contest 156 心得
abbrlink: '5794'
date: 2020-03-02 22:57:34
category: AtCoder
tags:
- AtCoder
- Math
- 模逆元
- Combinatorics 排列組合
---
virtual judge，賽中 4 題，這場後面都數論
<!-- more -->
* [A. Beginner](https://atcoder.jp/contests/abc156/tasks/abc156_a)
題意：給定比賽場次 $K$ 和 inner rating $R$，如果 $K<10$ 則 Displayed Rating 要減 $100\times(10-K)$，問 Displayed Rating 為多少
解法：if 判斷

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
    int n, r;
    cin >> n >> r;
    if(n < 10)
    {
        cout << r + 100 * (10 - n) << '\n';
    }
    else
    {
        cout << r << '\n';
    }
}
```

* [B. Digits](https://atcoder.jp/contests/abc156/tasks/abc156_b)
題意：問 $N$ 在 $K$ 進位要用多少位數表示
解法：直接計算 $N$ 要除以多少次 $K$ 才會等於 $0$

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
    int n, k, ans = 0;
    cin >> n >> k;
    while(n)
    {
        n /= k;
        ++ans;
    }
    cout << ans << '\n';
}
```

* [C. Rally](https://atcoder.jp/contests/abc156/tasks/abc156_c)
題意：給一整數數列，求一整數使得和數列每個數字平方和最小
解法：一般來說要找平均數，但是因為指定整數，所以需要找最靠近平均數的整數

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
    int n, k, ans = 0;
    cin >> n >> k;
    while(n)
    {
        n /= k;
        ++ans;
    }
    cout << ans << '\n';
}
```

* [D. Bouquet](https://atcoder.jp/contests/abc156/tasks/abc156_d)
題意：給定 $N$ 朵花，可以選其中 $1$ 到 $N$ 朵花來做裝飾，$A$ 和 $B$ 朵除外
解法：選其中 $1$ 到 $N$ 朵花的方法數有 $2^N-1$ 種，扣到 $C(N, A)$ 和 $C(N, B)$ 種，這題數字要用快速冪和模逆元求出答案。

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

LL pow2(LL n)
{
    LL tmp = 2, res = 1;
    for (; n > 0; n >>= 1)
    {
        if ((n & 1) != 0)
        {
            res = (res * tmp) % MOD;
        }
        tmp = (tmp * tmp) % MOD;
    }
    return res;
}

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

LL sol(LL m, LL n)
{
    LL x = 1, y = 1, tmp1, tmp2;
    for (LL i = m; i > m - n; --i){ x = (x * i) % MOD; }
    for (LL i = 1; i <= n; ++i){ y = (y * i) % MOD; }
    extgcd(y, MOD, tmp1, tmp2);
    x = (x * tmp1);
    return (x + MOD) % MOD;
}

int main()
{
    IOS;
    LL n, a, b;
    cin >> n >> a >> b;
    LL ans = (pow2(n) - 1 + MOD) % MOD;
    ans -= sol(n, a);
    ans -= sol(n, b);
    while(ans < MOD)
    {
        ans += MOD;
    }
    cout << (ans + MOD) % MOD << '\n';
}
```

* [E. Roaming](https://atcoder.jp/contests/abc156/tasks/abc156_e)
題意：有 $N$ 個人，每個人一開始都在各自的房間，每一天將一人移動到其他房間，問 $K$ 天後房間分布的可能性。
解法：換句話說每天都可以讓一間房間為空，所以可以選 $C(N,i)$ 間空房間，至於 $N$ 個人要分到剩下的 $N-i$ 間房間，可以例用放隔板的方式想，在 $N$ 之間的 $N-1$ 個間隔，選 $N-i-1$ 個地方放隔板，也就是 $C(n-1,n-i-1)$，所以要算出這題的答案，就枚舉所有可能的 $i$，算出 $C(N,i)\times C(n-1,n-i-1)$ 的答案就可以。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 200005;
const int MXV = 0;
const int MOD = 1e9 + 7;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

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

vector<LL> fac(MXN, 0), invfac(MXN, 0);

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

void build()
{
    fac[0] = fac[1] = 1;
    invfac[0] = invfac[1] = 1;
    FOR(i, 2, MXN)
    {
        fac[i] = (fac[i - 1] * i) % MOD;
        invfac[i] = inv(fac[i]);
    }
}

LL C(LL m, LL n)
{
    LL res = fac[m];
    res = (res * invfac[n]) % MOD;
    res = (res * invfac[m - n]) % MOD;
    return res;
}

int main()
{
    IOS;
    build();
    int n, k;
    cin >> n >> k;
    k = min(k, n - 1);
    LL ans = 0;
    FOR(i, 0, k + 1) { ans = (ans + (C(n, i) * C(n - 1, n - i - 1) % MOD)) % MOD; }
    cout << ans << '\n';
}
```

* [F. Modularness](https://atcoder.jp/contests/abc156/tasks/abc156_f)
題意：給定長度為 $K$ 的序列 $D$ 和 $Q$ 筆詢問，對於每筆詢問有三個整數 $n_i,x_i,m_i$，即為一個長度為 $n_i$ 的序列，$a_0=x_i,a_j=a_{j-1}+d_{j\ mod\ k}(j>0)$，問有幾個 $j$ 使得 $(a_j\ mod\ m_i)<(a_{j+1}\ mod\ m_i)$
解法：我們可以求不符合有有幾個，再用全部減去不符合的即為答案。我們先將所有 $d_i$ 都 $mod\ m$，不符合的有兩種，一種是 $(a_j\ mod\ m_i)=(a_{j+1}\ mod\ m_i)$，這種狀況在 $d_i\ mod\ m=0$ 的時候出現，第二種為 $(a_j\ mod\ m_i)>(a_{j+1}\ mod\ m_i)$，出現在 $\left \lfloor \frac{a_{i}}{m} \right \rfloor=\left \lfloor \frac{a_{i+1}}{m} \right \rfloor-1$ 的狀況，這種狀況要一次算，式子為 $\left \lfloor \frac{a_{n-1}}{m} \right \rfloor - \left \lfloor \frac{a_{0}}{m} \right \rfloor$

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 5005;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
vector<LL> d(MXN), a(MXN), zero(MXN), sum(MXN);

LL sol(LL k, LL n, LL x, LL m)
{
    x %= m;
    zero[0] = sum[0] = 0;
    FOR(i, 1, k + 1)
    {
        a[i] = d[i] % m;
        zero[i] = zero[i - 1] + (a[i] == 0);
        sum[i] = sum[i - 1] + a[i];
    }
    LL ans = n - 1;
    // cout << zero[k] << ' ' << sum[k] << '\n';
    ans -= ((n - 1) / k) * zero[k] + zero[(n - 1) % k];
    ans -= (((n - 1) / k) * sum[k] + sum[(n - 1) % k] + x) / m - x / m;
    return ans;
}

int main()
{
    IOS;
    int k, q;
    cin >> k >> q;
    FOR(i, 1, k + 1) { cin >> d[i]; }
    while(q--)
    {
        LL n, x, m;
        cin >> n >> x >> m;
        cout << sol(k, n, x, m) << '\n';
    }
}
```