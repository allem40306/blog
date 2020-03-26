---
title: AtCoder Beginner Contest 158 心得
abbrlink: db15
date: 2020-03-25 21:58:59
category: AtCoder
tags:
- AtCoder
- stl
- deque
- dp
- bit
---
這場前面四題算好寫，第五題考思維，最後一題算題好題目。
<!-- more -->
* [A - Station and Bus](https://atcoder.jp/contests/abc158/tasks/abc158_a)
題意：詢問是否有相鄰兩站由不同公司營運的狀況。
解法：判斷香伶兩字串是否相等。

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
    string s;
    cin >> s;
    if (s[0] != s[1] || s[1] != s[2])
    {
        cout << "Yes\n";
    }
    else
    {
        cout << "No\n";
    }
}
```

* [B - Count Balls](https://atcoder.jp/contests/abc158/tasks/abc158_b)
題意：數球時，會先數 $A$ 顆藍色球，在數 $B$ 顆紅色球，問前 $N$ 顆球中共有機顆藍色球。
解法：利用除法算出已完整算出 $\frac{N}{A+B}$ 輪球，當中有 $\frac{N}{A+B}A$ 顆藍色球，剩下餘數最多只有 $A$ 藍色球，即為 $max(A,N\ mod\ (A+B))$ 顆。

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
    LL n, a, b;
    cin >> n >> a >> b;
    LL ans = n / (a + b) * a;
    n %= (a + b);
    ans += min(a, n);
    cout << ans << '\n';
}
```

* [C - Tax Increase](https://atcoder.jp/contests/abc158/tasks/abc158_c)
題意：問是否存在一個整數 $N$，使得 $N*0.1=b,N*0.08=a$(皆為無條件捨去)，如果有多組解，輸出最小的一個，無解輸出 $-1$。
解法：$N$ 必須介於 $[b*10,b*10+9]$ 之間，因為 b 剛好為 $N$ 除以 $10$ 的整數部分。對 $[b*10,b*10+9]$ 這區間每個數字去測試是否符合 $a$ 就能找出答案了。

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
    int a, b;
    cin >> a >> b;
    int ans = -1;
    FORD(i, b * 10 + 9, b * 10 - 1)
    {
        if(i * 8 / 100 == a)
        {
            ans = i;
        }
    }
    cout << ans << '\n';
}
```

* [D - String Formation](https://atcoder.jp/contests/abc158/tasks/abc158_d)
題意：給定一個初始字串 $Q$ 次操作，有兩種：在頭或尾插入字串、翻轉字串，最後輸出字串。
解法：可以直接用字串做，但是時間複雜度高達 $O(size)$，用 `deque` 把字串從重頭加入的時間成本壓成 $O(1)$，和一個 boolean 變數紀錄方向，把翻轉字串的時間成本也壓成 $O(1)$，就能在時限內過這一題。

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
    deque<char> dq;
    string s;
    int q;
    bool r = false;
    cin >> s >> q;
    FOR(i, 0, s.size()) { dq.push_back(s[i]); }
    while(q--)
    {
        int a, b;
        char c;
        cin >> a;
        if(a == 1)
        {
            r = !r;
        }
        else
        {
            cin >> b >> c;
            if(r ^ (b & 1))
            {
                dq.push_front(c);
            }
            else
            {
                dq.push_back(c);
            }
        }
    }
    if(r)
    {
        while(!dq.empty()){
            cout << dq.back();
            dq.pop_back();
        }
    }
    else
    {
        while(!dq.empty()){
            cout << dq.front();
            dq.pop_front();
        }
    }
    cout << '\n';
}
```

* [E - Divisible Substring](https://atcoder.jp/contests/abc158/tasks/abc158_e)
題意：給定一長度為 $N$ 數字字串，問有多少子字串化成整數後，為 $P$ 的倍數。
解法：這題是考餘數的應用，如果 $(abcdef-ef)\ mod\ p ==0$，那麼 $abcd$ 是 $p$ 的倍數，於是開一個陣列 `cnt` 紀錄 $s[i,n]\ mod\ p$ 的個數，當算出 $s[i,n]\ mod\ p$ 的值，就先將 $ans$ 加上 $cnt[s[i,n]\ mod\ p]$，再把 $cnt[s[i,n]\ mod\ p] +1$。如果 $p=2,5$ 就直接判斷末位數就好了。

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
const int MXN = 2e5 + 5;
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
    int n, p, tmp = 0, t = 1;
    LL ans = 0;
    string s;
    VI cnt(MXN, 0);
    cin >> n >> p >> s;
    if (p == 2 || p == 5)
    {
        FOR(i, 0, n)
        {
            if ((s[i] - '0') % p == 0)
            {
                ans += (i + 1);
            }
        }
    }
    else
    {
        cnt[0] = 1;
        FORD(i, n - 1, 0 - 1)
        {
            tmp = (tmp + ((int)(s[i] - '0') * t)) % p;
            ans += cnt[tmp]++;
            t = (t * 10) % p;
        }
    }
    cout << ans << '\n';
}
```

* [F - Removing Robots](https://atcoder.jp/contests/abc158/tasks/abc158_f)
題意：有 $N$ 隻機器人，各有座標 $X_i$ 和行走距離 $D_i$，一開始所有機器人都是關閉狀態，可以隨機打開幾隻機器人，當機器人打開時，會往 $+x$ 方向走 $X_i$ 的距離，然後消失。當走到其他機器人的座標，該機器人也會被開啟。問剩下的機器人共有幾種可能。
解法：先把機器人依座標由小到大排序，由後往前 dp，dp 有兩種轉移方式，如果第 $i$ 隻機器人沒被開啟，方法數是 $dp[i+1]$。如果第 $i$ 隻機器人被開啟，方法數是 $dp[R_i+1]$，$R_i$ 為最右邊會被第 $i$ 隻機器人而被開啟的機器人，可以先利用 `lower_bound` 求出最右邊會直接被影響的機器人 $k$，因為第 $i$ 隻機器人只會走到 $X_i+D_i+1$，所以要 $-1$，接著要求出 $max(L[i+1,k])$，這部分可以用 `BIT` (樹狀數組) 來維護。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 2e5;
const int MXV = 0;
const LL MOD = 998244353;
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

vector<int> bits(MXN, 0);

void update(int x, int val, int n)
{
    for (; x <= n; x += (x & (-x)))
    {
        bits[x] = max(bits[x], val);
    }
}

int query(int x)
{
    int ans = 0;
    for (; x > 0; x -= (x & (-x)))
    {
        ans = max(ans, bits[x]);
    }
    return ans;
}

int main()
{
    IOS;
    int n;
    cin >> n;
    vector<PII> data(n);
    vector<LL> dp(n + 1, 0);
    vector<int> res(n, 0);
    FOR(i, 0, n) { cin >> data[i].F >> data[i].S; }
    sort(data.begin(), data.end());
    dp[n] = 1;
    FORD(i, n - 1, 0 - 1)
    {
        res[i] = i;
        int pos = lower_bound(data.begin(), data.end(),
                              MP(data[i].F + data[i].S, 0)) -
                  data.begin() - 1;
        res[i] = max(res[i], query(pos + 1));
        update(i + 1, res[i], n);
        if(res[i] + 1 < (int)dp.size())
        {
            dp[i] = (dp[i + 1] + dp[res[i] + 1]) % MOD;
        }
        else
        {
            dp[i] = (dp[i + 1] + 1) % MOD;
        }
    }
    cout << dp[0] << '\n';
}
```