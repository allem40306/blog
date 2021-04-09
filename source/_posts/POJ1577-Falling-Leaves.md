---
title: POJ1577 Falling Leaves
abbrlink: e08e
date: 2020-10-22 21:06:00
category: POJ
tags:
- POJ
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://poj.org/problem?id=1577)
* 題意：給定一顆二元搜索樹，依序給葉節點的值、葉節點祖先的值、葉節點祖先的祖先的值。要你給出這棵樹的前序順序。
<!-- more -->
* 題解：這題要從最上層(最晚給的資料)開始插入二元樹，這樣就能還原出二元搜索樹。
```cpp=
#pragma GCC optimize(2)
#include <cstring>
#include <iostream>
#include <stack>
#include <string>
#include <vector>

using namespace std;
const int INF = 1e9;
const int MXN = 1e6 + 5;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(NULL);                                                             \
    cout.tie(NULL);                                                            \
    ios_base::sync_with_stdio(false);
struct Node
{
    char val;
    Node *Lc, *Rc;
    Node() : Lc(NULL), Rc(NULL) {}
};

Node *insert(Node *node, char val)
{
    if (node == NULL)
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

void dfs(Node *node)
{
    if (node == NULL)
    {
        return;
    }
    cout << node->val;
    dfs(node->Lc);
    dfs(node->Rc);
}

int main()
{
    IOS;
    string s;
    stack<string> st;
    while (cin >> s)
    {
        do
        {
            st.push(s);
        } while (cin >> s, isalpha(s[0]));
        Node *root = NULL;
        while (!st.empty())
        {
            s = st.top();
            st.pop();
            FOR(i, 0, s.size()) { root = insert(root, s[i]); }
        }
        dfs(root);
        cout << '\n';
    }
}
```