---
title: AtCoder Beginner Contest 152 心得
category: Atcoder
abbrlink: a495
date: 2020-01-21 23:38:06
tags:
  - graph
  - lcm
  - math
  - 排容原理
  - 模逆元
---
這場我用 virtual 打，第一次體驗，覺得不錯。前 4 題在時限內解完，後兩題後來也解出來了。

* [A](https://atcoder.jp/contests/abc152/tasks/abc152_a) AC or WA
題意：給你總題數和解出題數，問你是否全解出來了
解法：判斷是否相等

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n, m;
    cin >> n >> m;
    cout << ((n == m) ? "Yes\n" : "No\n");
}
{% endcodeblock %}

* [B](https://atcoder.jp/contests/abc152/tasks/abc152_b) Comparing Strings
題意：比較 a 個 b 組成的字串和 b 個 a 組成的字串(a, b 都是個位數)，輸出較小的
解法：直接比較 a, b

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int a, b;
    cin >> a >> b;
    if(a > b)
    {
        swap(a, b);
    }
    while(b--)
    {
        cout << a;
    }
    cout << '\n';
}
{% endcodeblock %}

* [C](https://atcoder.jp/contests/abc152/tasks/abc152_c) Low Elements
題意：問幾個數字左邊沒有比他小的數字
解法：邊往右邊疊代時，邊紀錄前 $n$ 個數的最大值，再和當前數字比較大小

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);

#include <bits/stdc++.h>
using namespace std;

int main()
{
    IOS
    int n, mn, ans = 0;
    cin >> n;
    mn = n + 5;
    for(int i = 0, x; i < n; ++i)
    {
        cin >> x;
        if(x < mn)
        {
            ++ans;
            mn = x;
        }
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* [D](https://atcoder.jp/contests/abc152/tasks/abc152_d) Handstand 2
題意：問 $1$ 到 $N$ 有幾組數字(x, y)滿足，x 的首位數 = y 的末位數，y 的首位數 = x 的末位數。注意 (x ,y) 和 (y, x) 視為兩組。
解法：cnt[i][j] 紀錄以 $i$ 開頭，以 $j$ 結尾的數字有幾個，每個數先把首位數和末位數算出來，加上出比它小且符合規則的數，最後把自己也記錄在 cnt 陣列裡。這裡我將 (x, x) 和 (x, y) 兩種形式分別計算。

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
LL cnt[10][10];

int findH(int x)
{
    while(x >= 10)
    {
        x /= 10;
    }
    return x;
}

int main()
{
    IOS;
    int n;
    LL ans1 = 0, ans2 = 0;
    cin >> n;
    for (int i = 1; i <= n; ++i)
    {
        int h = findH(i), e = i % 10;
        ans1 += cnt[e][h];
        if(h == e)
        {
            ++ans2;
        }
        // cout << cnt[e][h] << ' ' << h << ' ' << e << '\n';
        ++cnt[h][e];
    }
    // cout << ans1 << ' ' << ans2 << '\n';
    cout << ans1 * 2 + ans2 << '\n';
}
{% endcodeblock %}

* [E](https://atcoder.jp/contests/abc152/tasks/abc152_e) Flatten
題意：找出最小一組數字 b1, b2, ... bn 的總和，這組數字滿足 aibi = ajbj for all i, j >= 1 and <= n
解法：這題要找最大公因數，但數字太大要用質因數分解，最後除回去要用模逆元。我卡在質因數分解沒用加 p[i] * p[i] <= x，遇到好幾次 TLE。我發現有人寫 Python 用 10 行就 AC 了，好猛(扯)

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
const LL MOD = 1e9 + 7;
const int N = 1000005;
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
bitset<N> is_notp;
vector<int> p;
map<int, int> cnt;

void primeTable()
{
    is_notp.reset();
    is_notp[0] = is_notp[1] = 1;
    for (int i = 2; i < N; i++)
    {
        if (!is_notp[i])
        {
            p.push_back(i);
        }
        for (int j = 0; j < (int)p.size() && i * p[j] < N; j++)
        {
            is_notp[i * p[j]] = 1;
            if (i % p[j] == 0)
            {
                break;
            }
        }
    }
}

void Update(int idx, int val)
{
    if(cnt.find(idx) == cnt.end())
    {
        cnt[idx] = val;
    }
    else
    {
        cnt[idx] = max(cnt[idx], val);
    }
    return;
}

void Factorization(LL x)
{
    for (int i = 0, tmp; i < (int)p.size() && p[i] * p[i] <= x; ++i)
    {
        tmp = 0;
        while(x % p[i] == 0)
        {
            x /= p[i];
            ++tmp;
        }
        Update(p[i], tmp);
    }
    if(x != 1)
    {
        Update((int)x, 1);
    }
    return;
}

LL calcLCM() {
    LL ret = 1;
    for (auto it: cnt)
    {
        while(it.second--)
        {
            ret = (ret * it.first) % MOD;
        }
    }
    return ret;
}

LL pow2(LL a, LL b)
{ 
    LL ret = 1;
    for (;b; b >>= 1)
    {
        if((b & 1) != 0)
        {
            ret = (ret * a) % MOD;
        }
        a = (a * a) % MOD;
    }
    return ret;
}

int main()
{
    IOS;
    int n;
    vector<LL> v;
    primeTable();
    cin >> n;
    v.resize(n);
    for (int i = 0; i < n; ++i)
    {
        cin >> v[i];
        Factorization(v[i]);
    }
    LL ans = 0, LCM = calcLCM();
    for (int i = 0; i < n; ++i)
    {
        LL tmp = (LCM * pow2(v[i], MOD - 2)) % MOD;
        // cout << tmp << " \n"[i == n - 1];
        ans = (ans + tmp) % MOD;
    }
    cout << ans << '\n';

}
{% endcodeblock %}

* [F](https://atcoder.jp/contests/abc152/tasks/abc152_f) Tree and Constraints
題意：給你 N 點的樹，現在有一堆條件 Cx, Cy，要求 Cx 到 Cy 的路上至少要有一條邊塗黑色，問有多少種塗法。
解法：利用排容原理，將所有可能扣除所有條件組合"某些條件必不符合下，有幾種方法"，假設這些條件共有 k 條邊，上敘條件下共有 2^(n-1-k) 種辦法，利用這種算法這題難度就大幅下降，我覺得這題算一題優質題目，推薦大家寫寫看。

{% codeblock lang:cpp %}
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
const int MXN = 55;
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
vector<PII> G[MXN], cond;
vector<int> route[MXN][MXN];

bool dfs(int s, int t, int u, int p)
{
    if(t == u)
    {
        return true;
    }
    for(auto edge: G[u])
    {
        if(edge.first == p)
        {
            continue;
        }
        if(dfs(s, t, edge.first, u))
        {
            route[s][t].push_back(edge.second);
            return true;
        }
    }
    return false;
}

int main()
{
    // IOS;
    int n, m;
    cin >> n;
    for (int i = 0, x, y; i < n - 1; ++i)
    {
        cin >> x >> y;
        G[x].push_back({y, i});
        G[y].push_back({x, i});
    }
    cin >> m;
    cond.resize(m + 5);
    for (int i = 0; i < m; ++i)
    {
        cin >> cond[i].first >> cond[i].second;
        dfs(cond[i].first, cond[i].second, cond[i].first, -1);
    }
    LL ans = (1LL << (n - 1));
    bitset<MXN> chosen;
    for (int i = 1; i < (1 << m); ++i)
    {
        // cout << i << " here\n";
        chosen.reset();
        for (int j = 0; j < m; ++j)
        {
            if((i >> j) & 1)
            {
                int s = cond[j].first, t = cond[j].second;
                for(auto r: route[s][t])
                {
                    chosen[r] = true;
                }
            }
        }
        int cnt = chosen.count();
        // cout << "cnt:" << cnt << ' ' << (1LL << (n - 1 - cnt)) << '\n';
        if(__builtin_popcount(i) & 1)
        {
            ans -= (1LL << (n - 1 - cnt));
        }
        else
        {
            ans += (1LL << (n - 1 - cnt));
        }
    }
    cout << ans << '\n';
}
{% endcodeblock %}
