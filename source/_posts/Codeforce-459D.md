---
title: Codeforce 459D
category: Codeforce
tags:
  - Codeforce
  - bitIndexTree
  - IONCamp 2019
abbrlink: '6912'
date: 2019-07-31 14:46:28
---
https://codeforces.com/contest/459/problem/D
這題給定一個長度為`n`的數列`a`，要找所有數對`(i, j)`滿足`f(1, i, a_i) > f(j, n, a_j)`，` f(l, r, x)`定義為在`[i,j]`之間`=x`的個數。
這題的作法和逆序數對相同，只不過update和query的東西不同而已，我會先求出所有的`f(1, i, a_i)`，在由後往前計算答案。我因為沒算到會超過int吃了一次WA(<-母湯。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define lowbit(x) (x & (-x))
int n;
vector<long long> BIT;

void update(int x)
{
    for(; x <= n; x += lowbit(x))
    {
        ++BIT[x];
    }
}

long long  query(int x)
{
    long long  ans = 0;
    for(; x > 0; x -= lowbit(x))
    {
        ans += BIT[x];
    }
    return ans;
}

int main()
{
    vector<long long> v, v1, cnt, F; //f(i) = f(1,i,a_i) 
    cin >> n;
    v.resize(n);
    cnt.resize(n);
    F.resize(n);
    for(int i = 0; i != n; ++i)
    {
        cin >> v[i];
        v1.push_back(v[i]);
    }
    sort(v1.begin(), v1.end());
    v1.resize(unique(v1.begin(), v1.end()) - v1.begin());
    for(int i = 0, no; i != n; ++i)
    {
        no = lower_bound(v1.begin(), v1.end(), v[i]) - v1.begin();
        ++cnt[no];
        F[i] = cnt[no];
    }

    long long ans = 0;
    BIT.resize(2 * n, 0);
    for(int i = n - 1, no; i >= 0; --i)
    {
        no = lower_bound(v1.begin(), v1.end(), v[i]) - v1.begin();
        int q = cnt[no] - F[i] + 1;
        // cout << no << ' ' << F[i] << ' ' << q << '\n';
        ans += query(F[i] - 1);
        // cout << ans << '\n';
        update(q);
    }
    cout << ans << '\n';
}
{% endcodeblock %}