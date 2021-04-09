---
title: HDU5444 Elven Postman
abbrlink: '5992'
date: 2020-10-22 20:57:01
category: HDU
tags:
- HDU
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://acm.hdu.edu.cn/showproblem.php?pid=5444)
* 題意：給定一顆二元樹，給定多筆詢問，每筆詢問需要將起點到 $x$ 的路徑方向。
<!-- more -->
* 題解：建立好二元樹後，依據數字大小判斷要往哪個方向拜訪。
```cpp=
#pragma GCC optimize("O2")
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using ULL = unsigned long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
using VI = vector<int>;
using VVI = vector<vector<int>>;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
const double EPS = 1e-9;
const int MOD = 1e9 + 7;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i < (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i > (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
struct Node
{
    int val;
    Node *Lc, *Rc;
    Node() : Lc(nullptr), Rc(nullptr) {}
};

Node *insert(Node *node, int val)
{
    if (node == nullptr)
    {
        node = new Node();
        node->val = val;
    }
    else if (val < node->val)
    {
        node->Lc = insert(node->Lc, val);
    }
    else
    {
        node->Rc = insert(node->Rc, val);
    }
    return node;
}

void dfs(Node *node, int val)
{
    if (node == nullptr || node->val == val)
    {
        return;
    }
    if (val < node->val)
    {
        cout << 'E';
        dfs(node->Lc, val);
    }
    else
    {
        cout << 'W';
        dfs(node->Rc, val);
    }
}

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int n, q, x;
        cin >> n;
        Node *root = nullptr;
        FOR(i, 0, n)
        {
            cin >> x;
            root = insert(root, x);
        }
        cin >> q;
        FOR(i, 0, q)
        {
            cin >> x;
            dfs(root, x);
            cout << '\n';
        }
    }
}
```