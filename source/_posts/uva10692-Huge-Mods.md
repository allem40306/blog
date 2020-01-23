---
title: UVa 10692 Huge Mods
category: UVa
abbrlink: 2aef
date: 2019-10-12 11:29:55
tags:
---
https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1633
題意：求$a_1^{a_2^{...^{a_n}} \mod n}$
<!-- more -->
解法：運用歐拉定理(數學)：$a^b\equiv a^{b\ mod\ \phi(n) + \phi(n)}\ mod\ \phi(n)(x\geqq\phi(n))$，我們先判斷$(x\geqq\phi(n))$，決定是否要加上$\phi(n)$，我看別人寫的文章說這題UVa測資弱，要找別題測code。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N = 10005;
int n;
int phi[N], a[N];

void phi_table(int n){
    phi[0] = 0; phi[1] = 1;
    for(int i = 2;i < n; i++){
        if(phi[i])continue;
        for(int j = i; j < n; j += i){
            if(!phi[j])phi[j] = j;
            phi[j] = phi[j] / i * (i - 1);
        }
    }
}

int sti(string s){
    int ret = 0;
    for(int i = 0;i < s.size(); i++){
        ret *= 10;
        ret += s[i] - '0';
    }
    return ret;
}

int POW(int a, int b, int mod){
    int ret = 1;
    int tmp = 1;
    for(int i = 0; i < b; i++){
        tmp *= a;
        if(tmp > mod)break;
    }
    tmp = (tmp >= mod) ? mod : 0;
    for(; b; b >>= 1){
        if(b & 1)ret = ret * a % mod;
        a = a * a % mod;
    }
    return ret + tmp;
}

int dfs(int d, int MOD){
    if(d == n - 1){
        if(a[d] >= MOD)return (a[d] % MOD) + MOD;
        return a[d];
    }
    int k = dfs(d + 1, phi[MOD]);
    return POW(a[d], k, MOD);
}

int main(){
    phi_table(N);
    int m, ti = 1;
    string s;
    while(cin >> s, s != "#"){
        m = sti(s);
        cin >> n;
        for(int i = 0; i < n; i++){
            cin >> a[i];
        }
        cout<< "Case #" << ti++ << ": " << dfs(0, m) % m << '\n' ;
    }
}
{% endcodeblock %}