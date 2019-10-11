---
title: Codeforces 1000F
category: Codeforces
tags:
  - Codeforces
  - segmentTree
  - IONCamp 2019
abbrlink: '3153'
date: 2019-07-29 22:41:47
---
https://codeforces.com/contest/1000/problem/F
這題給定一個數列A，給定Q筆詢問區間`[L, R]`，有沒有重複的數字，如果有請輸出任意一個，否則輸出0。

這題做參考IONCamp 2019講義，用離線做法，先將所有詢問讀入，然後依右邊界讀入，維護一個陣列pre，紀錄該位置的值上一次出現的位置，如果該位置的值和其他同值的位置比，不是最右邊的，就位置的pre就設為無限大，對於每筆詢問`[L, R]`，只要查詢`u=min(pre[L],pre[L + 1]...,pre[R])`，如果`u<L`代表有一個值只在這區間出現一次。
將相同值不在最右邊的所有位置其pre值設為無限大的用意，在於最該值取`min`不會讓最終答案`<L`，他無法成為解答(在他右邊至少有一個相同值的位置)。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using PII = pair<int,int>;
const int MXN = 500005;
struct Node{
    int val, mn;
    Node *lc, *rc;
    Node()
    {
        lc = rc = nullptr;
        mn = MXN;
    }
    void pull()
    {
        if(lc == nullptr)
        {
            mn = rc->mn;
            val = rc->val;
        }
        else if(rc == nullptr && mn > rc->mn)
        {
            mn = lc->mn;
            val = lc->val;
        }
        else if(lc->mn < rc->mn)
        {
            mn = lc->mn;
            val = lc->val;
        }
        else
        {
            mn = rc->mn;
            val = rc->val;
        }
        return;
    }
};
struct Query{
    int L, R, i, ans;
};
vector<int> a, pre, last;
vector<Query> vq;

Node* build(int L, int R)
{
    Node *node = new Node();
    if(L == R)
    { 
        node->val = a[L];
        node->mn = pre[L];
        return node;
    }
    int M = (L + R) >> 1;
    node->lc = build(L, M);
    node->rc = build(M + 1, R);
    node->pull();
    return node;
}

void modify(Node *node, int L, int R, int p)
{
    if(L == R)
    {
        node->val = a[p];
        node->mn = pre[p];
        return;
    }
    int M = (L + R) >> 1;
    if(p <= M)
    {
        modify(node->lc, L, M, p);
    }
    else
    {
        modify(node->rc, M + 1, R, p);
    }
    node->pull();
    return;
}

PII query(Node *node, int L, int R, int qL, int qR)
{
    if(qL <= L && R <= qR)
    {
        return {node->mn, node->val};
    }
    int M = (L + R) >> 1;
    if(qR <= M)
    {
        return query(node->lc, L, M, qL, qR);
    }
    if(qL > M)
    {
        return query(node->rc, M + 1, R, qL, qR);
    }
    else
    {
        return min(query(node->lc, L, M, qL, qR), query(node->rc, M + 1, R, qL, qR));
    }
    
}

int main()
{
    cin.tie(nullptr); ios_base::sync_with_stdio(false);
    int n, q;
    cin >> n;
    a.resize(n + 5);
    pre.resize(MXN);
    last.resize(MXN);
    fill(pre.begin(), pre.end(), MXN);
    fill(last.begin(), last.end(), MXN);
    for(int i = 1; i <= n; ++i)
    {
        cin >> a[i];
    }
    Node *root = build(1, n);
    
    cin >> q;
    vq.resize(q + 5);
    for(int i = 0; i != q; ++i)
    {
        vq[i].i = i;
        cin >> vq[i].L >> vq[i].R;
    }
    sort(vq.begin(), vq.begin() + q, 
        [](Query lhs, Query rhs)
        {
            return lhs.R < rhs.R;
        });
    
    int ni = 1;
    for(int i = 0; i != q; ++i)
    {
        while(ni <= vq[i].R)
        {
            int tmp = last[a[ni]];
            if(tmp != MXN)
            {
                pre[tmp] = MXN;
                modify(root, 1, n, tmp);
                pre[ni] = tmp;
            }
            else
            {
                pre[ni] = 0;
            }
            last[a[ni]] = ni;
            
            modify(root, 1, n, ni);
            ++ni;
        }
        auto ans = query(root, 1, n, vq[i].L, vq[i].R);
        // cout << vq[i].L << ' ' << vq[i].R << '\n';
        // cout << ans.first << '-' << ans.second << '\n';
        if(ans.first < vq[i].L)
        {
            vq[i].ans = ans.second;
        }
        else
        {
            vq[i].ans = 0;
        }
    }
    
    sort(vq.begin(), vq.begin() + q, 
        [](Query lhs, Query rhs)
        {
            return lhs.i < rhs.i;
        });
    for(int i = 0; i != q; ++i)
    {
        cout << vq[i].ans << '\n';
    }
}
{% endcodeblock %}