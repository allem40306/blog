---
title: Codeforces 834D
category: Codeforces
tags:
  - Codeforces
  - dp
  - segmentTree
  - IONCamp 2019
abbrlink: a8f5
date: 2019-08-01 16:35:01
---
https://codeforces.com/contest/833/problem/B
這題是要把長度為`n`數列`a`分成`k`段，要最大化每一段數字總類的和。
<!-- more -->
這題很顯然是用DP做，定義`dp[i][j]`為前`i`個數字切成`j`段，然後開一個`pre`陣列來維護該位置的值前一個相同的地方在哪裡，，對於每個`a[i]`，只會對`[pre[i], i - 1]`造成影響，這樣轉移時只要根據`pre`陣列就能用`O(n)`，時間複雜度為`O(n^2k)`，需用線段樹加速轉移。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
vector<int> dp, pre, last;

struct Node{
    int val, tag;
    Node *lc, *rc;
    Node(): lc(nullptr), rc(nullptr), tag(0){}
    void pull()
    {
        if(lc == nullptr)
        {
            val = rc->val;
        }
        else if(rc == nullptr)
        {
            val = lc->val;
        }
        else
        {
            val = max(lc->val, rc->val);
        }
        
    }
    void push()
    {
        if(lc != nullptr)
        {
            lc->tag += tag;
            lc->val += tag;
        }
        if(rc != nullptr)
        {
            rc->tag += tag;
            rc->val += tag;
        }
        tag = 0;
    }
};

Node* build(int L, int R)
{
    Node *node = new Node();
    if(L == R)
    {
        node->val = dp[L];
        return node;
    }
    int M = (L + R) >> 1;
    node->lc = build(L, M);
    node->rc = build(M + 1, R);
    node->pull();
    return node;
}

void update(Node *node, int L, int R, int qL, int qR, int v)
{
    if(qL <= L && R <= qR)
    {
        node->val += v;
        node->tag += v;
        return;
    }
    node->push();
    int M = (L + R) >> 1;
    if(qR <= M)
    {
        update(node->lc, L, M, qL, qR, v);
    }
    else if(M < qL)
    {
        update(node->rc, M + 1, R, qL, qR, v);
    }
    else
    {
        update(node->lc, L, M, qL, qR, v);
        update(node->rc, M + 1, R, qL, qR, v);
    }
    node->pull();
    return;
}

int query(Node *node, int L, int R, int qL, int qR)
{
    if(qL <= L && R <= qR)
    {
        return node->val;
    }
    node->push();
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
        return max(query(node->lc, L, M, qL, qR), query(node->rc, M + 1, R, qL, qR));
    }
    
}

int main()
{
    int n, k;
    cin >> n >> k;
    vector<int> v(n + 5);
    dp.resize(n + 5, 0);
    pre.resize(n + 5);
    last.resize(n + 5, 0);
    for(int i = 1; i <= n; ++i)
    {
        cin >> v[i];
        pre[i] = last[v[i]];
        last[v[i]] = i;
    }
    dp[0] = 0;
    Node *root;
    for(int j = 1; j <= k; ++j)
    {
        root = build(0, n);
        for(int i = 1; i <= n; ++i)
        {
            update(root, 0, n, pre[i], i - 1, 1);
            dp[i] = query(root, 0, n, 0, i - 1);
            // cout << j << ' ' << i << ' ' << dp[i] << '\n';
        }
    }
    cout << dp[n] << '\n';
}
{% endcodeblock %}