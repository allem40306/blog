---
title: AtCoder Beginner Contest 151 心得
category: Atcoder
tags:
  - Atcoder
  - bfs
  - math
  - map
  - stl
abbrlink: b1d5
date: 2020-01-18 20:15:31
---

這場作出前 4 題，賽後做了第 5 題，最後一題難度高所以沒做
參考：https://codeforces.com/blog/entry/73065
<!-- more -->
* [A](https://atcoder.jp/contests/abc151/tasks/abc151_a) Next Alphabet
題意：給定一個字母，輸出下一個字母
解法：不用多說了，就和題意一樣

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
 
int main()
{
    IOS;
    char ch;
    cin >> ch;
    cout << char(ch + 1) << '\n';
}
{% endcodeblock %}


* [B](https://atcoder.jp/contests/abc151/tasks/abc151_b) Achieve the Goal
題意：考 $N$ 科科目，分數從 $0$ 到 $K$，給定前 $N - 1$ 科分數，問最後一科要考多少平均才能達到 $M$ 分
解法：先算出總共要多少分，把前 $N - 1$ 科分數扣到即為答案。

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
 
int main()
{
    IOS;
    int n, m, k;
    cin >> n >> k >> m ;
    int ans = n * m;
    for(int i = 1, x; i < n; ++i)
    {
        cin >> x;
        ans -= x;
    }
    if(ans > k)
    {
        cout << -1 << '\n';
    }
    else
    {
        cout << max(0, ans) << '\n';
    }
}
{% endcodeblock %}

* [C](https://atcoder.jp/contests/abc151/tasks/abc151_c) Welcome to AtCoder
題意：給定一系列提交結果，要你算出 AC 和 WA 會被計算幾次(和平常計算方式相同)
解法：用 map 紀錄每題 WA 次數，當題目第一次 AC，就把該題當前 WA 次數也計算起來。

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, m, ta = 0, tp = 0;
    map<int, int> mp;
    string s;
    cin >> n >> m;
    for(int i = 0, p; i < m; ++i)
    {
        cin >> p >> s;
        if(mp.find(p) == mp.end())
        {
            mp[p] = 0;
        }
        if(mp[p] == -1)
        {
            continue;
        }
        if(s == "AC")
        {
            ++ta;
            tp += mp[p];
            mp[p] = -1;
        }
        else
        {
            mp[p] += 1;
        }
    }
    cout << ta << ' ' << tp << '\n';
}
{% endcodeblock %}


* [D](https://atcoder.jp/contests/abc151/tasks/abc151_d) Maze Master
題意：問哪兩點得最短路徑最長
解法：對每一個點 BFS 一次

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
const int MXV = 25;
string s[MXV];
 
int d[MXV][MXV];
int dx[4] = {1, 0, -1, 0}, dy[4] = {0, 1, 0, -1};
int bfs(int h, int w, int a, int b)
{
    int mx = 0;
    queue<PII> q;
    q.push({a, b});
    memset(d, -1, sizeof(d));
    d[a][b] = 0;
    while(!q.empty())
    {
        PII k = q.front(); q.pop();
        for(int i = 0, x, y; i < 4; ++i)
        {
            x = k.first + dx[i];
            y = k.second + dy[i];
            if(x < 0 || x >= h || y < 0 || y >= w)
            {
                continue;
            }
            if(s[x][y] == '.' && d[x][y] == -1)
            {
                d[x][y] = d[k.first][k.second] + 1;
                mx = max(mx, d[x][y]);
                q.push({x, y});
            }
        }
    }
    return mx;
}
 
int main()
{
    IOS;
    int h, w;
    cin >> h >> w;
    for(int i = 0; i < h; ++i)
    {
        cin >> s[i];
    }
    int ans = 0;
    for(int i = 0; i < h; ++i)
    {
        for(int j = 0; j < w; ++j)
        {
            if(s[i][j] == '#')
            {
                continue;
            }
            ans = max(ans, bfs(h, w, i, j));
        }
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* [E](https://atcoder.jp/contests/abc151/tasks/abc151_e) Max-Min Sums
題意：將 $N$ 個數字取 $K$ 個得所有組合，`最大值 - 最小值`加總為多少
解法：算出每個數當最大最小值的次數，分別做加減動作，這題還要算出 $N!$ 和 $\frac{1}{N!}$ 在 mod $10^9 + 7$ 的結果，所以會用到模逆元。

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
const LL MOD = 1e9 + 7;
const int MXN = 100005;
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
 
int main()
{
    IOS;
    int n, k;
    vector<int> v;
    pre();
 
    cin >> n >> k;
    v.resize(n);
    for (int i = 0; i < n; ++i)
    {
        cin >> v[i];
    }
    sort(v.begin(), v.end());
 
    LL ans = 0;
 
    for (int i = k - 1; i < n; ++i)
    {
        LL cnt = choose(i, k - 1);
        // cout << i << ' ' << k - 1 << ' ' << cnt << ' ' << v[i] << '\n';
        LL tmp = ((v[i] % MOD) * cnt) % MOD;
        ans = (ans + tmp) % MOD;
    }
 
    for (int i = n - k; i >= 0; --i)
    {
        LL cnt = choose(n - i - 1, k - 1);
        // cout << n - i - 1 << ' ' << k - 1 << ' ' << cnt << ' ' << v[i] << '\n';
        LL tmp = ((v[i] % MOD) * cnt) % MOD;
        ans = (ans - tmp + MOD) % MOD;
    }
 
    cout << ans << '\n';
}
{% endcodeblock %}