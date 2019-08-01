---
title: Codeforce 747F
date: 2019-08-01 18:43:02
category: Codeforce
tags: 
- Codeforce
- segmentTree
- math
- IONCamp 2019
---
https://codeforces.com/contest/474/problem/F
給定一個長度為`N`的數列`a`，給定`Q`筆詢問`[L,R]`之間有幾個數不能整除該區間至少一個數。
在區間裡，只有該區間最大公因數可以整除所有的數而已，所以就用線段數維護區間GCD，在查詢時算數該區間=GCD的數字個數(設為`x`)，答案即為`所有個數-x`。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int, int>;
vector<int> v;
struct Node{
    int gcd, cnt;
    Node *lc, *rc;
    Node(): gcd(0), cnt(0), lc(nullptr), rc(nullptr){};
    void pull()
    {
        gcd = __gcd(lc->gcd, rc->gcd);
        if(lc->gcd == gcd)
        {
            cnt += lc->cnt;
        }
        if(rc->gcd == gcd)
        {
            cnt += rc->cnt;
        }
    }
};

Node *build(int L, int R)
{
    Node *node = new Node();
    if(L == R)
    {
        node->gcd = v[L];
        node->cnt = 1;
        return node;
    }
    int M = (L + R) >> 1;
    node->lc = build(L, M);
    node->rc = build(M + 1, R);
    node->pull();
    return node;
}

PII query(Node *node, int L, int R, int qL, int qR)
{
    if(qL <= L && R <= qR)
    {
        return {node->gcd, node->cnt};
    }
    int M = (L + R) >> 1;
    if(qR <= M)
    {
        return query(node->lc, L, M, qL, qR);
    }
    else if (M < qL)
    {
        return query(node->rc, M + 1, R, qL, qR);
    }
    else
    {
        auto lhs = query(node->lc, L, M, qL, qR);
        auto rhs = query(node->rc, M + 1, R, qL, qR);
        int gcd = __gcd(lhs.first, rhs.first), cnt = 0;
        if(lhs.first == gcd)
        {
            cnt += lhs.second;
        }
        if(rhs.first == gcd)
        {
            cnt += rhs.second;
        }
        return {gcd, cnt};
    }
}

int main()
{
    int n, q;
    cin >> n;
    v.resize(n + 5);
    for(int i = 1; i <= n; ++i)
    {
        cin >> v[i];
    }
    Node *root = build(1, n);
    cin >> q;
    for(int i = 0, x, y; i != q; ++i)
    {
        cin >> x >> y;
        cout << y - x + 1 - query(root, 1, n, x, y).second << '\n';
    }
}
{% endcodeblock %}