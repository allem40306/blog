---
title: AtCoder Beginner Contest 155 心得
abbrlink: 42d4
date: 2020-02-23 15:40:54
category: AtCoder
tags:
- AtCoder
- stl
- map
- binary search
- dp
- graph
---
這場有點挑戰性，賽中只對了前三題。
<!-- more -->
* [A. Poor](https://atcoder.jp/contests/abc155/tasks/abc155_a)
題意：給三個數，問是否剛好其中兩數相同。
解法：直接跑迴圈判斷。

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
    int cnt = 0;
    vector<int> v(3);
    cin >> v[0] >> v[1] >> v[2];
    FOR(i, 0, 3)
    {
        FOR(j, i + 1, 3)
        {
            if(v[i] == v[j])
            {
                ++cnt;
            }
        }
    }
    if(cnt == 1)
    {
        cout << "Yes\n";
    }
    else
    {
        cout << "No\n";
    }
}
```

* [B. Papers, Please](https://atcoder.jp/contests/abc155/tasks/abc155_b)
題意：問有沒有不能被 $3$ 和 $5$ 整除的偶數。
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

int main()
{
    IOS;
    int n, x;
    cin >> n;
    bool ok = true;
    FOR(i, 0, n)
    {
        cin >> x;
        if (x % 2 == 0 && x % 3 != 0 && x % 5 != 0)
        {
            ok = false;
        }
    }
    if (ok)
    {
        cout << "APPROVED\n";
    }
    else
    {
        cout << "DENIED\n";
    }
}
```

* [C. Poll](https://atcoder.jp/contests/abc155/tasks/abc155_c)
題意：問出現次數最高的單字，如果超過一個，請依照字典序輸出。
解法：用 `map` 就好了。

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
    int n, mx = 0;
    cin >> n;
    map<string, int> tb;
    string s;
    FOR(i, 0, n)
    {
        cin >> s;
        if(tb.find(s) == tb.end())
        {
            tb[s] = 0;
        }
        tb[s] += 1;
        if(mx < tb[s])
        {
            mx = tb[s];
        }
    }
    for(auto it: tb)
    {
        if(it.S == mx)
        {
            cout << it.F << '\n';
        }
    }
}
```

* [D. Pairs](https://atcoder.jp/contests/abc155/tasks/abc155_d)
題意：有 $N$ 個數字，任意兩數相乘的一乘積，為第 $K$ 小的數為和? 
解法：二分搜包二分搜，外層二分搜答案，內層搜尋 $a_i$ 和幾個數相乘會小於某數。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const LL INF = 1e18;
const int MXN = 0;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define Fi first
#define Se second
#define Be begin()
#define En end()
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);

int main()
{
    // IOS;
    int n;
    LL k;
    cin >> n >> k;
    vector<LL> v(n);
    FOR(i, 0, n) { cin >> v[i]; }
    sort(v.Be, v.En);
    LL L = -INF, R = INF;
    while (L + 1 < R)
    {
        // cout << L << ' ' << R << '\n';
        LL M = (L + R) >> 1, cnt = 0;
        FOR(i, 0, n)
        {
            if (v[i] < 0)
            {
                int LL = -1, RR = n;
                while (LL + 1 < RR)
                {
                    int MM = (LL + RR) >> 1;
                    (v[i] * v[MM] < M) ? (RR = MM) : (LL = MM);
                }
                cnt += n - RR;
            }
            else
            {
                int LL = -1, RR = n;
                while (LL + 1 < RR)
                {
                    int MM = (LL + RR) >> 1;
                    (v[i] * v[MM] < M) ? (LL = MM) : (RR = MM);
                }
                cnt += RR;
            }
            if (v[i] * v[i] < M)
            {
                --cnt;
            }
        }
        cnt /= 2;
        // cout << M << ' ' << cnt << '\n';
        (cnt < k) ? (L = M) : (R = M);
    }
    cout << L << '\n';
}
```

* [E. Payment](https://atcoder.jp/contests/abc155/tasks/abc155_e)
題意：現在有硬幣有 $1,10,100,...,10^i$ 的面額，如果今天買了 $S$ 元，付款和找錢(加起來)最少要多少硬幣。
這裡提供 2 種解法，官解釋另外一種，可是我覺得沒有很漂亮就沒寫了。
解法 1：由低位數開始算，如果第 $i$ 位 $<5$ 是買方付，$>5$ 是賣方找，至於 $=5$ 就要看第 $i+1$ 位是否 $>5$，如果 $>5$ 就賣方找，否則就買方付。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 1000005;
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
    LL ans = 0;
    string s;   
    vector<LL> n(MXN, 0);
    cin >> s;
    s = '0' + s;
    FOR(i, 0, s.size())
    {
        n[i] = int(s[s.size() - 1 - i] - '0');
    }
    FOR(i, 0, s.size())
    {
        n[i + 1] += n[i] / 10;
        n[i] %= 10;
        if(n[i] > 5 || (n[i] == 5 && n[i + 1] >= 5))
        {
            ans += 10 - n[i];
            n[i] = 0;
            n[i + 1] += 1;
        }
        else
        {
            ans += n[i];
        }
    }
    cout << ans << '\n';
}
```

解法 2：利用 `dp` 解，$dp[i][j]$ 為第 $i$ 位由($j=0$:買方付；$j=1$:賣方找)，最少需要的硬幣數。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 1000005;
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
    vector<LL> n(MXN, 0);
    static LL dp[MXN][2];
    cin >> s;
    s = '0' + s;
    FOR(i, 0, s.size())
    {
        n[i] = int(s[s.size() - 1 - i] - '0');
    }
    dp[0][0] = n[0];
    dp[0][1] = (10 - n[0]);
    FOR(i, 1, s.size())
    {
        dp[i][0] = min(dp[i - 1][0] + n[i], dp[i - 1][1] + n[i] + 1);
        dp[i][1] = min(dp[i - 1][0] + (10 - n[i]), dp[i - 1][1] + 10 - (n[i] + 1));
    }
    cout << min(dp[(int)s.size() - 1][0], dp[(int)s.size() - 1][1]) << '\n';
}
```

* [F. Perils in Parallel](https://atcoder.jp/contests/abc155/tasks/abc155_f)
題意：有 $N$ 顆炸彈有各自的座標(相異)和狀態(開或關)，現有 $M$ 台機器，每台機器都可以使一區段的炸彈狀態轉換，問可不可以讓所有炸彈都變成關的狀況。
解法：炸彈依座標排序，先把兩兩相鄰炸彈求 $xor$ 值(兩邊界也要)，形成 $N + 1$ 個帶有值點，接著對於每台機器的區間找出對應的炸彈(點)，將兩點相連，這樣我們就建構一顆點上有值(0 or 1)的圖了。
回頭看 $xor$ 值，如果兩顆炸彈狀態不一樣，也就是有一顆炸彈是開著，那麼 $xor$ 值就是 $1$，想要全部炸彈都關閉，每個 $xor$ 值都要為 $0$。
那麼如果要滿足題目，我們的建構的圖中，每一個連通塊點上的值 $xor$ 起來要為 $0$ 才行，否則沒有辦法讓所有炸彈都變成關的狀態。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const LL INF = 1e18;
const int MXN = 100005;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define EB emplace_back
#define Fi first
#define Se second
#define Be begin()
#define En end()
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);

bitset<MXN> vis;
vector<int> ans, x;
vector<PII> G[MXN + 1];

int dfs(int u)
{
    vis[u] = true;
    int res = x[u];
    for (auto it : G[u])
    {
        if (!vis[it.Fi])
        {
            int tmp = dfs(it.Fi);
            if (tmp != 0)
            {
                ans.PB(it.Se);
            }
            res ^= tmp;
        }
    }
    return res;
}

int main()
{
    int n, m;
    cin >> n >> m;
    vector<PII> bombs(n);
    x.resize(n + 1);
    FOR(i, 0, n) { cin >> bombs[i].Fi >> bombs[i].Se; }
    sort(bombs.Be, bombs.En);
    x[0] = bombs[0].Se;
    FOR(i, 0, n - 1) { x[i + 1] = bombs[i].Se ^ bombs[i + 1].Se; }
    x[n] = bombs[n - 1].Se;

    FOR(i, 0, m)
    {
        int L, R;
        cin >> L >> R;
        L = lower_bound(bombs.Be, bombs.En, PII{L, 0}) - bombs.Be;
        R = upper_bound(bombs.Be, bombs.En, PII{R, 1}) - bombs.Be;
        G[L].EB(R, i + 1);
        G[R].EB(L, i + 1);
    }
    vis.reset();
    FOR(i, 0, n + 1)
    {
        if (vis[i])
        {
            continue;
        }
        if (dfs(i))
        {
            cout << "-1\n";
            return 0;
        }
    }
    cout << ans.size() << '\n';
    sort(ans.Be, ans.En);
    FOR(i, 0, ans.size()) { cout << ans[i] << " \n"[i == (int)ans.size() - 1]; }
}
```