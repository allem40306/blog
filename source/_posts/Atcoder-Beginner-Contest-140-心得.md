---
title: Atcoder Beginner Contest 140 心得
category: Atcoder
tags:
  - Atcoder
abbrlink: '3847'
date: 2019-10-03 15:12:49
---
這是我第一次打6題的AtCoder，太久沒打了，都不知道改賽制。

* PA Password([ABC 140A](https://atcoder.jp/contests/abc140/tasks/abc140_a))
題目：密碼有三位數，由`n`種數字組成，求組合數。
解法：輸出`n*n*n`。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main()
{
    int n;
    cin >> n;
    cout << n * n * n << '\n';
}
{% endcodeblock %}

* PB Buffet([ABC 140B](https://atcoder.jp/contests/abc140/tasks/abc140_b))
題目：有`N`盤點心，給定吃的順序`A`，吃編號第`i`盤的點心獲得`B_i`滿足感，如果在吃編號第`i`盤的點心後吃編號第`i+1`盤的點心，又可以獲得`C_i`滿足感，問最後滿足感。
解法：模擬

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N = 25;

int main()
{
    int n;
    int a[N], b[N], c[N];
    cin >> n;
    a[0] = -1;
    for(int i = 1; i <= n; ++i)
    {
        cin >> a[i];
    }
    for(int i = 1; i <= n; ++i)
    {
        cin >> b[i];
    }
    for(int i = 1; i != n; ++i)
    {
        cin >> c[i];
    }
    int ans = 0;
    for(int i = 1; i <= n; ++i)
    {
        ans += b[i];
        if(a[i] == a[i - 1] + 1)
        {
            ans += c[a[i- 1]];
        }
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PC Maximal Value([ABC 140C](https://atcoder.jp/contests/abc140/tasks/abc140_c))
題目：給定數列`A`相鄰兩數max所形成的數列`B`，問所有數字總和max
解法：如果$A_i$大於$min(B_i, B_{i + 1})$，必會形成contradition(矛盾)，如果$A_i$小於$min(B_i, B_{i + 1})$，代表$A_i$還可以再變成更大，所以$A_i$必等於$min(B_i, B_{i + 1})$，要注意邊界計算。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 105;
int main()
{
    int n, ans = 0;
    int a[MXN];
    cin >> n;
    for(int i = 1; i != n; ++i)
    {
        cin >> a[i];
    }
    ans += a[1] + a[n - 1];
    for(int i = 2; i != n; ++i)
    {
        ans += min(a[i], a[i - 1]);
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PD Face Produces Unhappiness([ABC 140D](https://atcoder.jp/contests/abc140/tasks/abc140_d))
題目：每個人站向左或右邊，如果面對到的人跟自己朝同方向就會開心，有`K`筆操作使得一區間的人都轉向，問最後最多有幾個人會開心。
解法：
如果$N$個人都是同向，如`RRRRR`，最右邊的人會不開心，有$N - 1$個人會不開心。
如果最左/右邊的人不同向，如`RRRRL`，最右邊的兩人也會不開心，有$N - 1 - 1 = N - 2$個人會不開心。
如果中間其中一人不同向，如`RRRLR`或，會有$N - 1 - 2 = N - 3$個人會不開心。
之後發現如果有`p`對相鄰兩人不同向，會有$N - 1 - p$個人會不開心。
每一次操作可以消除至多2對不同向的情形，所以先算出有相鄰不同向對數`p`，再看能消除幾對，即可算出答案。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n, k, tmp;
    string s;
    while(cin >> n >> k >> s)
    {
        tmp = 0;
        for(int i = 1; i != n; ++i)
        {
            tmp += (s[i] != s[i - 1]);
        }
        cout << n - 1  - max(0, tmp - 2 * k);
    }
}

{% endcodeblock %}

* PE Second Sum([ABC 140E](https://atcoder.jp/contests/abc140/tasks/abc140_e))
題目：給定一序列$A$，問所有區間第二大的總和。
解法：我們可以算出每個數字當第二大的序列總數，要算出序列總數，必需先左右兩邊第一個比他大的數字，這個資訊可以用`mutliset`先講值由大到小存入位置，藉由`lower_bound`找出。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, LL>;

int main()
{
    int n;
    vector<PII> v;
    multiset<int> s;
    cin >> n;
    for(int i = 1, x; i <= n; ++i)
    {
        cin >> x;
        v.push_back({x, i});
    }
    sort(v.begin(), v.end(), greater<PII>());
    s.insert(0); s.insert(0);
    s.insert(n + 1); s.insert(n + 1);
    LL ans = 0;
    for(auto i: v)
    {
        int num = i.first, p = i.second;
        auto it = s.lower_bound(p);
        int R2 = *(++it), R1 = *(--it);
        int L2 = *(--it), L1 = *(--it);
        // cout << num << ' ' << p << '\n';
        // cout << '(' << L1 << ',' << L2 << ')' << '(' << R1 << ',' << R2 << ')' << '\n';
        ans += num * 1LL * (R2 - R1) * (p - L2);
        // cout << ans << ' ';
        ans += num * 1LL * (R1 - p) * (L2 - L1);
        // cout << ans << '\n';
        s.insert(p);
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PF Many Slimes([ABC 140F](https://atcoder.jp/contests/abc140/tasks/abc140_f))
題目：我覺得直接看題目比較看
解法：模擬，利用`set`找出第一個`<=`該值的數字。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
int n;
vector<int> v, w;

bool sol()
{
    map<int, int, greater<int>> tb;
    for(int i = 1; i != (int) v.size(); ++i)
    {
        if(tb.find(v[i]) == tb.end())
        {
            tb[v[i]] = 0;
        }
        ++tb[v[i]];
    }
    w.push_back(v[0]);
    for(int i = 0; i < n; ++i)
    {
        for(int j = 0; j < (1LL << i); ++j)
        {
            auto it = tb.upper_bound(w[j]);
            if(it == tb.end())
            {
                return false;
            }
            w.push_back((*it).first);
            --(*it).second;
            if((*it).second == 0)
            {
                tb.erase(it);
            }
        }
        sort(w.begin(), w.end(), greater<int>());
    }
    return true;
}

int main(){
    cin >> n;
    v.resize((1 << n));
    for(int i = 0; i != (1 << n); ++i)
    {
        cin >> v[i];
    }
    sort(v.begin(), v.end(), greater<int>());
    if(sol())
    {
        cout << "Yes\n";
    }
    else
    {
        cout << "No\n";
    }   
    
}
{% endcodeblock %}