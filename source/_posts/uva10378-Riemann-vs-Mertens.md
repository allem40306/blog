---
title: uva10378 Riemann vs Mertens
abbrlink: 59be
date: 2020-02-04 12:42:18
category: UVa
tags:
- UVa
- Math
- Möbius function
---
題意：要你算出 Möbius function 第 $n$ 項和前 $n$ 項總和，Möbius function 定義為 $\mu(n)=\left\{\begin{array}{}1 && 無平方質因數存在，且質因數個數為偶數\\-1 && 無平方質因數存在，且質因數個數為奇數\\0 && 有平方質因數存在\end{array}\right.$
解法：直接做質因數分解就可以過了，這題主要考的是如何對質因數分解，並理解什麼是 Möbius function，我覺得可以作為教 Möbius function 的基礎題。

```cpp
#pragma GCC optimize(2)
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int,int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 1000005;
const int MXV = 0;
#define MP  make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for(int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for(int i = L; i != (int)R; --i)
#define IOS cin.tie(nullptr); cout.tie(nullptr); ios_base::sync_with_stdio(false);
bitset<MXN> is_notp;
vector<int> p;

void primeTable()
{
    is_notp.reset();
    is_notp[0] = is_notp[1] = 1;
    for (int i = 2; i * i < MXN; ++i)
    {
        if (!is_notp[i])
        {
            p.push_back(i);
        }
        for (int j = 0; j < (int)p.size() && i * p[j] < MXN; j++)
        {
            is_notp[i * p[j]] = 1;
            if (i % p[j] == 0)
            {
                break;
            }
        }
    }
}

vector<int> a(MXN, 0), sum(MXN, 0);

void primeFactor(int x)
{
    int y = x, primeFactor = 0;
    bool squareFree = true;
    for(auto i: p)
    {
        if(y < i)
        {
            break;
        }
        if(y % i != 0)
        {
            continue;
        }
        ++primeFactor;
        y /= i;
        while(y % i == 0)
        {
            squareFree = false;
            y /= i;
        }
    }
    if(y != 1)
    {
        ++primeFactor;
    }
    if(squareFree == false)
    {
        a[x] = 0;
    }
    else
    {
        a[x] = ((primeFactor & 1) ? -1 : 1);
    }
    sum[x] = sum[x - 1] + a[x];
    return;
}

int main()
{
    IOS;
    primeTable();
    FOR(i, 1, MXN) { primeFactor(i); }
    int n;
    while(cin >> n, n)
    {
        cout << setw(8) << n << setw(8) <<  a[n] << setw(8) <<  sum[n] << '\n';
    }
}
```