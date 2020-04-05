---
title: Codeforces 1304 Round 620 Div.2
abbrlink: '7412'
date: 2020-03-20 17:08:13
category: Codeforces
tags:
- Codeforces
---
這場比賽我是自己一題一題寫的，比起一般的 AtCoder 還要難。
<!-- more -->
* [A. Two Rabbits](https://vjudge.net/problem/CodeForces-1304A/origin)
題意：有兩隻兔子，一隻在 $x$，一隻在 $y$，兩隻兔子往彼此的方向跳，一隻每秒跳 $a$ 單位，一隻每秒跳 $b$ 單位，問兩隻兔子會不會在某個時間相遇到，如果會遇到，輸出幾秒會遇到。
題解：一開始的距離如果是每秒靠近的距離的倍數，就會遇到，遇到的時間為$\frac{一開始的距離}{每秒靠近的距離}$。

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
    LL x, y, a, b;
    cin >> t;
    FOR(ti, 0, t)
    {
        cin >> x >> y >> a >> b;
        if (abs(x - y) % (a + b) == 0)
        {
            cout << abs(x - y) / (a + b) << '\n';
        }
        else
        {
            cout << "-1\n";
        }
    }
}
```


* [B. Longest Palindrome](https://vjudge.net/problem/CodeForces-1304B/origin)
題意：給定 $N$ 個長度為 $M$ 的字串，問能組出最長回文字串為何。
題解：講互相回文的字串兩兩一組，中間可以放一個自己形成回文的字串，就能組出最長的回文字串。

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

bool ok(int sz, string &s, string &r)
{
    FOR(i, 0, sz)
    {
        if (s[i] != r[sz - i - 1])
        {
            return false;
        }
    }
    return true;
}

int main()
{
    IOS;
    int n, m, middleString = -1;
    cin >> n >> m;
    vector<string> s(n);
    vector<int> match(n, -1);
    FOR(i, 0, n) { cin >> s[i]; }
    FOR(i, 0, n)
    {
        if (match[i] != -1)
        {
            continue;
        }
        FOR(j, i + 1, n)
        {
            if (ok(m, s[i], s[j]))
            {
                match[i] = j;
                match[j] = i;
                break;
            }
        }
        if(middleString == -1 && ok(m, s[i], s[i]))
        {
            middleString = i;
        }
    }
    stack<int> choose;
    string ans = "";
    FOR(i, 0, n)
    {
        if(match[i] != -1 && i < match[i])
        {
            ans += s[i];
            choose.push(match[i]);
        }
    }
    if(middleString != -1)
    {
        ans += s[middleString];
    }
    while(!choose.empty())
    {
        int k = choose.top();
        choose.pop();
        ans += s[k];
    }
    cout << (int)ans.size() << '\n';
    cout << ans << '\n';
}
```

* [C. Air Conditioner](https://vjudge.net/problem/CodeForces-1304C/origin)
題意：一間有 $N$ 個客人要光臨的餐館，一開始的溫度為 $m$，地 $i$ 位客人在 $t_i$ 時刻到來，喜歡的溫度在 $[l_i,r_i]$ 之間，每單位時間可以升高或降低一度，也可以不調溫度，問有沒有辦法讓每個客人都在自己滿意的溫度用餐。
題解：假設某一刻的溫度在 $X$，$T$ 秒後溫度有可能的區間為 $[X-T,X+T]$，我們可以先把客人依照時間先後排序，從 $0$ 秒開始將每個客人的區間和可能的區間取交集，如果交集為空，就有每一位客人沒辦法滿足。

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

struct Data
{
    int t, L, R;
    void read() { cin >> t >> L >> R; }
    bool operator<(const Data &rhs) const { return t < rhs.t; }
};
vector<Data> v;

int main()
{
    IOS;
    int q;
    cin >> q;
    while (q--)
    {
        int t, L, R, now = 0;
        cin >> t >> L;
        R = L;
        v.resize(t);
        FOR(i, 0, t) { v[i].read(); }
        sort(v.begin(), v.end());
        bool ok = true;
        FOR(i, 0, t)
        {
            int disT = abs(v[i].t - now);
            // [L-disT,R+disT]
            int newL = max(L - disT, v[i].L);
            int newR = min(R + disT, v[i].R);
            if (newL > newR)
            {
                ok = false;
                break;
            }
            L = newL;
            R = newR;
            now = v[i].t;
        }
        cout << (ok ? "YES\n" : "NO\n");
    }
}
```

* [D. Shortest and Longest LIS](https://vjudge.net/problem/CodeForces-1304D/origin)
題意：有 $N$ 個數，可以隨機放置，但要滿足 $N-1$ 個相鄰關係($<,+,>$)，分別求出一組最小和最大長度的 LIS。
題解：如果要求出最小長度的 LIS，大個數要放後面，越前面連續 `<` 區間，要放越大的數字；反之，如果要求出最大長度的 LIS，大個數要放後面，越前面連續 `>` 區間，要放越小的數字。

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
    int t, n;
    string s;
    cin >> t;
    vector<int> ans;
    while(t--)
    {
        cin >> n >> s;
        ans.resize(n);
        int now = n, last = 0;
        FOR(i, 0, n)
        {
            if(i == n - 1 || s[i] == '>')
            {
                FORD(j, i, last - 1) { ans[j] = now--; }
                last = i + 1;
            }
        }
        FOR(i, 0, n) { cout << ans[i] << " \n"[i == n - 1]; }
        now = 1, last = 0;
        FOR(i, 0, n)
        {
            if(i == n - 1 || s[i] == '<')
            {
                FORD(j, i, last - 1) { ans[j] = now++; }
                last = i + 1;
            }
        }
        FOR(i, 0, n) { cout << ans[i] << " \n"[i == n - 1]; }
    }
}
```

* [E. 1-Trees and Queries](https://vjudge.net/problem/CodeForces-1304E/origin)
題意：給定一張 $N$ 個點的圖，和 $Q$ 筆詢問，每筆詢問給定起點終點 $a,b$，並在 $x,y$ 加上一條邊(針對該筆詢問)，問能不能有一條從 $a$ 到 $b$ 的路徑剛好可以走 $K$ 步，邊和點都可以重複走。
題解：有三種走法，$a\to b$，$a\to x\to b$，$a\to y\to b$，只要這三條不重複的走法 $<=K$，且和 $K$ 都是奇(偶)數，因為可以重複一條路走多次，相當於步數 $+2$，要先用 LCA 算出任意兩點的距離

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 1e5 + 5;
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

const int LOG = 20;
vector<int> tin(MXV), tout(MXV), depth(MXV);
int par[MXV][LOG];
int timer = 0;
vector<int> G[MXV];

void dfs(int u, int f)
{
    tin[u] = ++timer;
    par[u][0] = f;
    for (int v : G[u])
    {
        if (v != f)
        {
            depth[v] = depth[u] + 1;
            dfs(v, u);
        }
    }
    tout[u] = ++timer;
}

void Doubling(int n)
{
    for (int j = 1; j < LOG; ++j)
    {
        for (int i = 1; i <= n; ++i)
        {
            par[i][j] = par[par[i][j - 1]][j - 1];
        }
    }
}

bool anc(int u, int v) { return tin[u] <= tin[v] && tout[v] <= tout[u]; }

int LCA(int u, int v)
{
    if (depth[u] > depth[v])
    {
        swap(u, v);
    }
    if (anc(u, v))
    {
        return u;
    }
    for (int j = LOG - 1; j >= 0; --j)
    {
        if (!anc(par[u][j], v))
            u = par[u][j];
    }
    return par[u][0];
}

int dis(int u, int v)
{
    int lca = LCA(u, v);
    return depth[u] + depth[v] - 2 * depth[lca];
}

int main()
{
    IOS;
    int n;
    cin >> n;
    FOR(i, 1, n)
    {
        int u, v;
        cin >> u >> v;
        G[u].push_back(v);
        G[v].push_back(u);
    }
    int root = 1;
    depth[root] = 0;
    dfs(root, root);
    Doubling(n);
    int q;
    cin >> q;
    while (q--)
    {
        int x, y, a, b, k;
        cin >> x >> y >> a >> b >> k;
        int w[3];
        w[0] = k - dis(a, b);
        w[1] = k - (dis(a, x) + dis(y, b) + 1);
        w[2] = k - (dis(a, y) + dis(x, b) + 1);
        bool ok = false;
        FOR(i, 0, 3)
        {
            if (w[i] >= 0 && w[i] % 2 == 0)
            {
                ok = true;
            }
        }
        cout << (ok ? "YES\n" : "NO\n");
    }
}
```

* Animal Observation [easy](https://vjudge.net/problem/CodeForces-1304F1/origin), [hard](https://vjudge.net/problem/CodeForces-1304F2/origin)
題意：動物分成 $M$ 區，每區每天都有不同數量的動物，有兩架攝影機，奇數天可以設置一架攝影機，偶數天設另一架，每架可已錄到連續 $K$ 區，問 $N$ 天內最多可以錄到多少動物，兩架攝影機重疊的地方只能算一次。這題有兩個版本，差別在於 $K$ 的大小。
題解：設 $dp[i][j]$ 為第 $i$ 設置攝影機在位置 $j$ 的，最多可以錄到多少動物，第 $i$ 天要從第 $i-1$ 天的轉移，沒有重疊的可以直接累加起來，這裡可以用 $Lmax$ 和 $Rmax$ 分別記錄前綴和後綴最大值來加速計算，在 $[j-k+1,j+k-1]$ 的範圍裡則是重疊的，要額外去計算。這樣的作法為 $O(MNK)$。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 55;
const int MXM = 2e4 + 5;
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

int sum[MXN][MXM], dp[MXN][MXM], Lmax[MXN][MXM], Rmax[MXN][MXM];

int getSum(int x, int L, int R) { return sum[x][R] - sum[x][L - 1]; }

int main()
{
    IOS;
    int n, m, k;
    cin >> n >> m >> k;
    FOR(i, 1, n + 1) FOR(j, 1, m + 1)
    {
        cin >> sum[i][j];
        sum[i][j] = sum[i][j - 1] + sum[i][j];
    }
    FOR(i, 1, n + 1)
    {
        FOR(j, 1, m - k + 2)
        {
            int ksum = getSum(i, j, j + k - 1) + getSum(i + 1, j, j + k - 1);
            if (i == 1)
            {
                dp[i][j] = ksum;
                continue;
            }
            FOR(x, max(1, j - k + 1), min(j + k - 1, m - k + 1) + 1)
            {
                int overlapSum =
                    getSum(i, max(j, x), min(j + k - 1, x + k - 1));
                dp[i][j] = max(dp[i][j], dp[i - 1][x] + ksum - overlapSum);
            }
            if (j - k > 0)
            {
                dp[i][j] = max(dp[i][j], ksum + Lmax[i - 1][j - k]);
            }
            if (j + k <= m)
            {
                dp[i][j] = max(dp[i][j], ksum + Rmax[i - 1][j + k]);
            }
        }
        FOR(j, 1, m - k + 2) { Lmax[i][j] = max(Lmax[i][j - 1], dp[i][j]); }
        FORD(j, m - k + 1, 0) { Rmax[i][j] = max(Rmax[i][j + 1], dp[i][j]); }
    }
    int ans = 0;
    FOR(i, 1, m - k + 2) { ans = max(ans, dp[n][i]); }
    cout << ans << '\n';
}
```

困難版的作法有兩種，一種用線段樹達到 $O(nm\log m)$，還有一種用單調對列優化可達到 $O(NM)$。我是用單調對列優化，從左至右看，對於候選 $a,b,a<b$，他們對於任意一個和他們都有重疊的 $j,b<j$ 可以貢獻的差異是固定的，由右至左的情況也是一樣。依照這個特性使用單調堆列優化，就可以計算重疊部分的最佳解的複雜度壓到 $O(NM)$。

心得：這題除了複習單調對列優化，我還學到怎麼用 `vector` 開二維陣列，以及如何把序列正反兩方向用同個函式做單調對列優化。

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
const int MXN = 55;
const int MXM = 2e4 + 5;
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

int n, m, k;
VVI init(MXN, VI(MXM, 0));
VVI a, rev_a, sum, rev_sum, Lmax, Rmax, dp, dpL, dpR;

int getSum(VVI &sum, int x, int L, int R)
{
    if (L < 1)
    {
        return sum[x][R];
    }
    return sum[x][R] - sum[x][L - 1];
}

void calc_overlapped(VVI &sum, VVI &dp, int i)
{
    deque<PII> dq;
    FOR(j, 1, m - k + 2)
    {
        int num = dp[i - 1][j] - getSum(sum, i, j, j + k - 1);
        while (!dq.empty() && dq.front().S <= j - k)
        {
            dq.pop_front();
        }
        while (!dq.empty() &&
               dq.back().F + getSum(sum, i, dq.back().S, j - 1) <= num)
        {
            dq.pop_back();
        }
        dq.push_back({num, j});
        dp[i][j] = dq.front().F + getSum(sum, i, dq.front().S, j - 1) +
                   getSum(sum, i, j, j + k - 1) +
                   getSum(sum, i + 1, j, j + k - 1);
    }
}

int main()
{
    IOS;
    cin >> n >> m >> k;
    a = rev_a = sum = rev_sum = Lmax = Rmax = dp = dpL = dpR = init;
    FOR(i, 1, n + 1)
    {
        FOR(j, 1, m + 1)
        {
            cin >> a[i][j];
            sum[i][j] = sum[i][j - 1] + a[i][j];
        }
        FOR(j, 1, m + 1)
        {
            rev_a[i][j] = a[i][m - j + 1];
            rev_sum[i][j] = rev_sum[i][j - 1] + rev_a[i][j];
        }
    }
    FOR(i, 1, n + 1)
    {
        FOR(j, 1, m - k + 2)
        {
            int ksum =
                getSum(sum, i, j, j + k - 1) + getSum(sum, i + 1, j, j + k - 1);
            dp[i][j] = ksum;
            if (j - k > 0)
            {
                dp[i][j] = max(dp[i][j], ksum + Lmax[i - 1][j - k]);
            }
            if (j + k <= m - k + 1)
            {
                dp[i][j] = max(dp[i][j], ksum + Rmax[i - 1][j + k]);
            }
        }

        calc_overlapped(sum, dpL, i);
        calc_overlapped(rev_sum, dpR, i);

        FOR(j, 1, m - k + 2)
        {
            // m - k - j + 2 = (m - k + 1) - j + 1
            dp[i][j] = max({dp[i][j], dpL[i][j], dpR[i][m - k - j + 2]});
            dpL[i][j] = dpR[i][m - k - j + 2] = dp[i][j];
        }

        FOR(j, 1, m - k + 2) { Lmax[i][j] = max(Lmax[i][j - 1], dp[i][j]); }
        FORD(j, m - k + 1, 0) { Rmax[i][j] = max(Rmax[i][j + 1], dp[i][j]); }
    }
    int ans = 0;
    FOR(i, 1, m - k + 2) { ans = max(ans, dp[n][i]); }
    cout << ans << '\n';
}
```
