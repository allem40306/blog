---
title: AtCoder Beginner Contest 153 心得
abbrlink: '6854'
date: 2020-02-08 20:17:40
category: AtCoder
tags:
- AtCoder
- dp
- 背包dp
- 差分
- binary search
---
這次都是怪物系列XD。我用 virtual 比賽，前五題賽中過，最後一題賽後過
<!-- more -->
* [A. Serval vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_a)
題意：給你怪獸的血量 $H$ 和一次攻擊殺傷力 $A$，問需攻擊幾下才能擊倒怪物
解法：直接相除，如果沒整除要加 $1$

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
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, m;
    cin >> n >> m;
    cout << n / m + (n % m != 0) * 1 << '\n';
}
```

* [B. Common Raccoon vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_b)
題意：給你怪獸的血量 $H$ 和 $N$ 種不同的攻擊殺傷力 $A_i$，問是否能在這 $N$ 次擊倒怪物
解法：直接相減

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
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, m;
    cin >> n >> m;
    for(int i = 0, x; i < m; ++i)
    {
        cin >> x;
        n -= x;
    }
    cout << ((n <= 0) ? "Yes\n" : "No\n");
}
```

* [C. Fennec vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_c)
題意：有 $N$ 隻怪獸血量為 $H_i$，你有無限制一般攻擊使得一隻怪物血量 $-1$，以及 $K$ 次特殊攻擊使得一隻怪物血量歸 $0$，問最少要使出幾次一般攻擊
解法：將特殊攻擊拿去對付血量前 $K$ 高的怪物，剩下怪物血量即為答案

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
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, k;
    cin >> n >> k;
    vector<LL> v(n);
    for(int i = 0; i < n; ++i)
    {
        cin >> v[i];
    }
    sort(v.begin(), v.end());
    LL ans = 0;
    for(int i = 0; i < n - k; ++i)
    {
        ans += v[i];
    }
    cout << ans << '\n';
}
```

* [D. Caracal vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_d)
題意：攻擊一隻血量為 $H$ 的怪獸，會變成兩隻 $\frac{H}{2}$ (整數除法)的怪獸，問要攻擊幾次才能消滅怪物
解法：遞迴解，消滅一隻血量為 $i$ 的怪物所需次數，等於消滅兩隻 $\frac{H}{2}$ 的怪獸再加 $1$(攻擊血量為 $i$ 的怪物的那下)

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
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

LL sol(LL x)
{
    if(x == 1)
    {
        return 1;
    }
    return 2 * sol(x / 2) + 1;
}

int main()
{
    IOS;
    LL h;
    cin >> h;
    cout << sol(h) << '\n';
}
```

* [E. Crested Ibis vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_e)
題意：給怪物血量 $H$，和 $N$ 種可重複使用招數之殺傷力 $A_i$ 和花費 $B_i$，為最低需要多少花費才能消滅怪物
解法：這題可以用無限背包解出，但要注意最低花費介於 $dp[n]$ 至 $dp[2n-1]$ 之間

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 20005;
const int MXV = 0;
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
vector<int> dp(MXN, INF);

void sol(int a, int b)
{
    for(int i = a; i < MXN; ++i)
    {
        dp[i] = min(dp[i], dp[i - a] + b);
    }
}

int main()
{
    IOS;
    int h, n;
    cin >> h >> n;
    dp[0] = 0;
    for (int i = 0, a, b; i < n; ++i)
    {
        cin >> a >> b;
        sol(a, b);
    }
    cout << *min_element(dp.begin() + h, dp.begin() + MXN) << '\n';
}
```

* [F. Silver Fox vs Monster](https://atcoder.jp/contests/abc153/tasks/abc153_f)
題意：有 $N$ 隻怪獸在位置 $X_i$ (接相異)、血量為 $H_i$，有炸彈可以對某位置正負 $D$ 範圍內的怪獸造成 $A$ 的攻擊力，問至少要幾顆炸彈
解法：假設炸彈最左端為 $x$，那麼最右端會在 $x+2\times D$，所以一顆炸彈可對 $[x,x+2D]$ 扣 $A$，我們要利用差分的技巧模擬。設一個陣列 $sum$，每次到 $sum[i]$ 都要加上 $sum[i-1]$，並對怪物依照位置由小到大排序，當要對 $[x,x+2D]$ 扣 $A$ 時，就在 $sum[i]$ 扣 $t$，$sum[i+2D+1]$ 加回 $t$，要找最靠近 $i+2D+1$ 的怪物，需要用到二分搜。這題讓我學到差分這個技巧，算個大收穫吧!

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
LL n, d, a;
vector<int> sum;
vector<PLL> monsters; // (x, h)

LL sol()
{
    LL ans = 0;
    FOR(i, 0, n)
    {
        if (i)
        {
            sum[i] += sum[i - 1];
        }
        monsters[i].S += sum[i];
        if (monsters[i].S <= 0)
        {
            continue;
        }
        int L = i, R = n, R2 = i, M;
        while (L <= R)
        {
            M = (L + R) >> 1;
            if (monsters[i].F + 2 * d >= monsters[M].F)
            {
                R2 = M;
                L = M + 1;
            }
            else
            {
                R = M - 1;
            }
        }
        LL tmp = (monsters[i].S / a);
        if (monsters[i].S % a > 0)
        {
            ++tmp;
        }
        ans += tmp;
        sum[i] -= tmp * a;
        sum[R2 + 1] += tmp * a;
    }
    return ans;
}

int main()
{
    // IOS;
    cin >> n >> d >> a;
    monsters.resize(n);
    sum.resize(n + 5, 0);
    FOR(i, 0, n) { cin >> monsters[i].F >> monsters[i].S; }
    sort(monsters.begin(), monsters.end());
    cout << sol() << '\n';
}
```