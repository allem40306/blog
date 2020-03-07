---
title: AtCoder Beginner Contest 157 心得
abbrlink: 9b55
date: 2020-03-07 14:17:45
category: AtCoder
tags:
- AtCoder
- stl
- map
- set
- disjoint set
---
這場我直接寫，有點難度，最後一題解不出來。
<!-- more -->

* [A. Duplex Printing](https://atcoder.jp/contests/abc152/tasks/abc157_a)
題意：一張紙印兩頁，$N$ 頁需用幾張紙。
解法：直接加一除以二，避免奇數少算一頁。

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
    int n;
    cin >> n;
    cout << (n + 1) / 2 << '\n';
}
```

* [B. Bingo](https://atcoder.jp/contests/abc152/tasks/abc157_b)
題意：給定一個賓果盤 $N$ 個喊出的數字，問是否賓果。
解法：用 `map` 將賓果盤上數字對應位置，如果喊出來的數字在盤上就標記下來，最後檢查有沒有連線。

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
    map<int, int> tb;
    bitset<3> bingo[3];
    FOR(i, 0, 3) { bingo[i].reset(); }
    int n;
    int x;
    FOR(i, 0, 9)
    {
        cin >> x;
        tb.insert({x, i});
    }
    cin >> n;
    FOR(i, 0, n)
    {
        cin >> x;
        if (tb.find(x) == tb.end())
        {
            continue;
        }
        int res = tb[x];
        int a = res / 3, b = res % 3;
        bingo[a][b] = true;
    }
    bool ok = false;
    if(bingo[0][0] && bingo[1][1] && bingo[2][2])
    {
        ok = true;
    }
    if(bingo[0][2] && bingo[1][1] && bingo[2][0])
    {
        ok = true;
    }
    FOR(i, 0, 3)
    {
        if(bingo[0][i] && bingo[1][i] && bingo[2][i])
        {
            ok = true;
        }
        if(bingo[i][0] && bingo[i][1] && bingo[i][2])
        {
            ok = true;
        }
    }
    cout << (ok ? "Yes\n" : "No\n");
}
```

* [C. Guess The Number](https://atcoder.jp/contests/abc152/tasks/abc157_c)
題意：給定 $M$ 個條件，為一個 $N$ 位數的第 $s_i$ 位須為 $c_i$，請找出一個符合這些條件之最小的數字，找不到請輸出 $-1$。
解法：這題要考的是細心度，有很多種狀況要考慮，我參考其他人的辦法，將情況分為只有 $1$ 位數和多位數討論，才拿到 AC。

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
    int n, m;
    int d[5];
    bool ok = true;
    memset(d, -1, sizeof(d));
    cin >> n >> m;
    FOR(i, 0, m)
    {
        int s, c;
        cin >> s >> c;
        if (d[s] != -1 && d[s] != c)
        {
            ok = false;
            break;
        }
        d[s] = c;
    }
    if (ok == false)
    {
        cout << "-1\n";
    }
    else if (n == 1)
    {
        cout << ((d[1] == -1) ? 0 : d[1]) << '\n';
    }
    else
    {
        if (d[1] == 0)
        {
            cout << -1 << '\n';
        }
        else
        {
            FOR(i, 1, n + 1)
            {
                if (d[i] == -1)
                {
                    cout << (i == 1 ? 1 : 0);
                }
                else
                {
                    cout << d[i];
                }
            }
            cout << '\n';
        }
    }
}
```

* [D. Friend Suggestions](https://atcoder.jp/contests/abc152/tasks/abc157_d)
題意：有 $N$ 個人，有 $M$ 個好友關係，有 $K$ 個敵人關係，可以經由朋友認識其他好友，問每人可多認識幾個好友。
解法：人轉成點，關係轉成邊，只考慮好友關係的邊，可以認識的人一定在同個連通塊，所以先算出每個連通塊個數，減去朋友數，再減去同一個連通塊敵人個數，就可得到答案。

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

struct DisjointSet
{
    int p[MXV], sz[MXV];
    void init(int n)
    {
        for (int i = 0; i <= n; i++)
        {
            p[i] = i;
            sz[i] = 1;
        }
    }
    int find(int u) { return u == p[u] ? u : p[u] = find(p[u]); }
    void Union(int u, int v)
    {
        u = find(u);
        v = find(v);
        if (u == v)
        {
            return;
        }
        if (sz[u] < sz[v])
        {
            swap(u, v);
        }
        sz[u] += sz[v];
        p[v] = u;
    }
    bool isSame(int u, int v)
    {
        u = find(u);
        v = find(v);
        return u == v;
    }
    int getSize(int u)
    {
        u = find(u);
        return sz[u];
    }
};

int main()
{
    IOS;
    DisjointSet djs;
    int n, m, k;
    cin >> n >> m >> k;
    vector<int> ans(n + 1, 0);
    djs.init(n);
    FOR(i, 0, m)
    {
        int x, y;
        cin >> x >> y;
        --ans[x];
        --ans[y];
        djs.Union(x, y);
    }
    FOR(i, 0, k)
    {
        int x, y;
        cin >> x >> y;
        if (djs.isSame(x, y))
        {
            --ans[x];
            --ans[y];
        }
    }
    // FOR(i, 1, n + 1) { cout << ans[i] << " \n"[i == n]; }
    FOR(i, 1, n + 1) { cout << ans[i] + djs.getSize(i) - 1 << " \n"[i == n]; }
}
```

* [E. Simple String Queries](https://atcoder.jp/contests/abc152/tasks/abc157_e)
題意：給定長度為 $N$ 的字串 $S$，和 $Q$ 筆操作，操作有兩種，一是更換其中字元，一是詢問某區間字元種數，根據每筆詢問輸出答案。
解法：一開始我想是不是要用線段樹之類的資料結構，後來看解答，才知道開 $26$ 顆 `set` 紀錄每種字元出現的位置就可以了，詢問就利用 `lower_bound` 查詢每種字元是否有該詢問的區間內就行了。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 30;
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
    int n, q;
    string s;
    set<int> alp[MXN];
    cin >> n >> s >> q;
    FOR(i, 0, MXN)
    {
        alp[i].insert(0);
        alp[i].insert(n + 1);
    }
    FOR(i, 0, n) { alp[s[i] - 'a'].insert(i + 1); }
    FOR(i, 0, q)
    {
        int x;
        cin >> x;
        // cout << x << '\n';
        if (x == 2)
        {
            int y, z, ans = 0;
            cin >> y >> z;
            // cout << y << ' ' << z << '\n';
            FOR(j, 0, MXN)
            {

                // cout << j << ' ' << *alp[j].lower_bound(y) << ' '
                //      << k << "\n";
                if (*alp[j].lower_bound(y) <= z)
                {
                    ++ans;
                }
            }
            cout << ans << '\n';
        }
        else
        {
            int y;
            char z;
            cin >> y >> z;
            alp[s[y - 1] - 'a'].erase(y);
            s[y - 1] = z;
            alp[s[y - 1] - 'a'].insert(y);
        }
    }
}
```