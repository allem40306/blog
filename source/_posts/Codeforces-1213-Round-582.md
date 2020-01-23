---
title: Codeforces 1213 (Round 582)
category: Codeforces
abbrlink: baa2
date: 2019-10-11 14:42:02
tags:
- Codeforces
- graph
---
這是一場Div 3 的比賽，Virtual + 檢討下來我覺得不會很難，但經驗太少，在比的時候想不出來，只有PE我覺得出點有的不好之外其他題目都不錯。
<!-- more -->
比賽網址：https://codeforces.com/contest/1213

* PA Chips Moving
題意：有n個chip在一維座標上，每次可以移動1或2格，其中移動1格需要花費一單位成本，問至少要花多少成本才能所有chip在同一個座標點。
解法：可以先以"移動2格"的方式，分別將偶數點和奇數點的chips分別集中，在把其中比較小堆的chips移動1格到另一堆。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int n, odd = 0, even = 0;
    cin >> n;
    for(int i = 0, x; i != n; ++i)
    {
        cin >> x;
        if(x & 1)
        {
            ++odd;
        }
        else
        {
            ++even;
        }
    }
    cout << min(odd, even) << '\n';
}
{% endcodeblock %}

* PB Bad Prices
題意：給定一個序列$A$，問有幾個數後面有比它小的數。
解法：由後往前判斷，紀錄後$N$個數字中最小值，跟要比較的數字相比。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 150005;
 
int main()
{
    int t, n, a[MXN];
    cin >> t;
    while(t--)
    {
        cin >> n;
        for(int i = 0; i != n; ++i)
        {
            cin >> a[i];
        }
        int ans = 0, mn = a[n - 1];
        for(int i = n - 2; i >= 0; --i)
        {
            if(a[i] > mn)
            {
                ++ans;
            }
            mn = min(mn, a[i]);
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PC
題意：問你$1~N$中，是$M$的所有數之個位數總和。
解法：假設乘積個位數只會跟乘數和被乘數的個位數有關，所以只要算出$M$的$0$到$9$倍的個位數，並算出有幾個是$M$的倍數，就能推出答案了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = unsigned long long;
 
int main(){
    int q;
    LL n, m;
    vector<LL> v(15);
    cin >> q;
    while(q--)
    {
        v.clear();
        cin >> n >> m;
        v[0] = 0;
        for(int i = 1; i != 10; ++i)
        {
            v[i] = m * i % 10 + v[i - 1];
        }
        v[10] = v[9];
        LL tmp = n / m;
        cout << (tmp / 10) * v[10] + v[tmp % 10] << '\n';
    }
}
{% endcodeblock %}

* PD Equalizing by Division
題意：有$n$個數字，有一操作可以讓數字直接除以2(無條件捨去)，問要做幾次操作才能讓$k$個數字一樣。
解法：
這題有兩種難度，差別在於$n$的大小。
第一種可以先枚舉所有可能會出現的數字，再分別對每個數字算出要幾次操作才能有$k$個該數字。
第二種先算出每個數字對於"經過操作後所能變成的數"的貢獻，再對每個數字求出最小需要的操作數即可。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int n, k;
    vector<int> v, w;
    cin >> n >> k;
    v.resize(n);
    for(int i = 0; i != n; ++i)
    {
        cin >> v[i];
        int tmp = v[i];
        while(1)
        {
            w.push_back(tmp);
            if(!tmp)
            {
                break;
            }
            tmp /= 2;
        }
    }
    sort(w.begin(), w.end());
    w.resize(unique(w.begin(), w.end()) - w.begin());
    int ans = 500000;
    vector<int> times;
    for(int i = 0; i != (int)w.size(); ++i)
    {
        times.clear();
        for(int j = 0; j != n; ++j)
        {
            int cnt = 0, tmp = v[j];
            while(tmp > v[i])
            {
                tmp /= 2;
                ++cnt;
            }
            if(tmp == v[i])
            {
                times.push_back(cnt);
            }
        }
        if((int)times.size() < k)
        {
            continue;
        }
        sort(times.begin(), times.end());
        ans = min(ans, accumulate(times.begin(), times.begin() + k, 0));
    }
    cout << ans << '\n';
}
{% endcodeblock %}

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 200005;
vector<int> v, times[MXN];
 
int main(){
    int n, k;
    cin >> n >> k;
    v.resize(n);
    for(int i = 0; i != MXN; ++i)
    {
        times[i].clear();
    }
    for(int i = 0; i != n; ++i)
    {
        cin >> v[i];
        int tmp = v[i], cnt = 0;
        while(1)
        {
            times[tmp].push_back(cnt);
            if(!tmp)
            {
                break;
            }
            tmp /= 2;
            ++cnt;
        }
    }
    int ans = 500000000;
    for(int i = 0; i != MXN; ++i)
    {
        if((int)times[i].size() < k)
        {
            continue;
        }
        sort(times[i].begin(), times[i].end());
        ans = min(ans, accumulate(times[i].begin(), times[i].begin() + k, 0));
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PE Two Small Strings
題意：要你構造出$3\times n$的字串，字元`a, b, c`各有$n$個，其中不能包含`s, t`兩字串(長度為2)
解法：構造出`abcabc...`和`aaa...bbb...ccc...`兩種字串分別檢查。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
void sol(int n, string s, string t)
{
    string tmp = "abc", res;
    do
    {
        res = string(n, tmp[0]) + string(n, tmp[1]) + string(n, tmp[2]);
        if(res.find(s) == string::npos && res.find(t) == string::npos)
        {
            cout << "YES\n" << res << '\n';
            return;
        }
        res = "";
        for(int i = 0; i != n; ++i)
        {
            res += tmp;
        }
        if(res.find(s) == string::npos && res.find(t) == string::npos)
        {
            cout << "YES\n" << res << '\n';
            return;
        }
    }while(next_permutation(tmp.begin(), tmp.end()));
    cout << "NO\n";
    return;
}
 
int main()
{
    int n;
    string s, t, ans1, ans2;
    cin >> n >> s >> t;
    sol(n, s, t);    
}
{% endcodeblock %}

* PF Unstable String Sort
題意：找出一種字串由`a`到`z`組成的字串，使得$s[a[1]]\leq s[a[2]]\leq s[a[3]]\leq s[a[4]]$且$s[b[1]]\leq s[b[2]]\leq s[b[3]]\leq s[b[4]]$，並且至少要由$k$個字元組成。
解法：如果$s[x]\leq s[y]$且$s[y]\leq s[x]$那麼$s[x]=s[y]$，所以如果$a[L], a[L+1], a[L+2], ... a[R]=b[L], b[L+1], b[L+2], ... b[R]$，我們就把這區間的字元全部設為一樣的。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int n, k;
    cin >> n >> k;
    vector<int> a(n), b(n), ansTag;
    for(int i = 0; i != n; ++i)
    {
        cin >> a[i];
    }
    for(int i = 0; i != n; ++i)
    {
        cin >> b[i];
    }
    set<int> s1, s2;
    for(int i = 0; i != n; ++i)
    {
        if(s2.count(a[i]))
        {
            s2.erase(a[i]);
        }
        else
        {
            s1.insert(a[i]);
        }
        if (s1.count(b[i]))
        {
            s1.erase(b[i]);
        }
        else
        {
            s2.insert(b[i]);
        }
        if(s1.empty() && s2.empty())
        {
            ansTag.push_back(i);
        }        
    }
    if((int)ansTag.size() < k)
    {
        cout << "NO\n";
    }
    else
    {
        cout << "YES\n";
        int j = 0;
        string ans(n, ' ');
        for(int i = 0; i != n; ++i)
        {
            ans[a[i] - 1] = char('a' + min(j, 25));
            if(i == ansTag[j])
            {
                j++;
            }
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

* PG Path Queries
題意：給定一棵樹和$m$筆詢問，對於每筆詢問求出有多少點對其路徑上的邊權$\leq m_i$
解法：幫邊和詢問都由小到大排序，對於每筆詢問，將$\leq m_i$的邊加進來，一邊維護有多少點對符合所求。作法類似再求最小生成樹。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
const int MXN = 200005;
LL now_ans;
 
LL cal(LL n)
{
    if(n < 2)
    {
        return 0;
    }
    return n * (n - 1) / 2;
}
 
struct Edge
{
    int from, to, w;
    bool operator<(const Edge&rhs)const
    {
        return w < rhs.w;
    }
};
 
struct DisJointSet
{
    int p[MXN], sz[MXN];
    void init(int n)
    {
        for(int i = 0; i <= n; ++i)
        {
            p[i] = i;
            sz[i] = 1;
        }
    }
    int Find(int x)
    {
        if(x == p[x])
        {
            return x;
        }
        return p[x] = Find(p[x]);
    }
    void Union(int x, int y)
    {
        x = Find(x);
        y = Find(y);
        if(x == y)
        {
            return;
        }
        now_ans -= cal((LL)sz[x]) + cal((LL)sz[y]);
        if(sz[x] < sz[y])
        {
            swap(x, y);
        }
        p[y] = x;
        sz[x] += sz[y];
        now_ans += cal((LL)sz[x]);
    }
};
 
int main()
{
    int n, m;
    cin >> n >> m;
    vector<LL> ans(m);
    vector<Edge> edges(n - 1);
    vector<PII> querys;
    DisJointSet djs;
    djs.init(n);
    for(int i = 0; i != n - 1; ++i)
    {
        cin >> edges[i].from >> edges[i].to >> edges[i].w;
    }
    sort(edges.begin(), edges.end());
    for(int i = 0, x; i != m; ++i)
    {
        cin >> x;
        querys.push_back(make_pair(x, i));
    }
    sort(querys.begin(), querys.end());
    now_ans = 0;
    int i = 0;
    for(auto query: querys)
    {
        while(i < (int)edges.size() && edges[i].w <= query.first)
        {
            djs.Union(edges[i].from, edges[i].to);
            ++i;
        }
        ans[query.second] = now_ans;
    }
    for(int i = 0; i != m; ++i)
    {
        cout << ans[i] << " \n"[i == m - 1];
    }
}
{% endcodeblock %}