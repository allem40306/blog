---
title: POJ1785
abbrlink: 11ab
date: 2020-10-22 20:59:29
category: POJ
tags:
- POJ
- Tree
- 笛卡爾樹
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](http://poj.org/problem?id=1785)
* 題意：給定 $N$ 顆節點，要構出笛卡爾樹並中序輸出
<!-- more -->
* 題解：笛卡爾樹是一顆符合樹性質和根性質的樹，Treap 也是一種笛卡兒樹，職不過 Treap 的 val 是隨機的。要構造一顆笛卡爾樹，先將節點依 key 值排序，依序插入樹中，每顆節點依開始在樹的最右邊，往父親方向，找出第一個 key > 當前節點 key 的祖先 $P$，將 $P$ 的右子節點設為當前節點，$P$ 原本的右子節點設為當前節點的左子樹。
* 參考：https://oi-wiki.org/ds/cartesian-tree/#treap
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <map>
#include <string>
#include <vector>

using namespace std;
typedef long long LL;
const int INF = 1e9;
const int MXN = 5e4 + 5;
const int MXS = 1e2 + 5;
const LL MOD = 10009;
const LL seed = 31;
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
char s[MXN][MXS];
struct Node
{
    int key, val;
    int Lc, Rc, p;
    bool operator<(const Node &rhs) const
    {
        return strcmp(s[key], s[rhs.key]) < 0;
    }
} node[MXN];

void insert(int x)
{
    int y = x - 1;
    while (node[y].val < node[x].val)
    {
        y = node[y].p;
    }
    node[x].Lc = node[y].Rc;
    node[node[x].Lc].p = x;
    node[y].Rc = x;
    node[x].p = y;
}

void dfs(int x)
{
    if (x == 0)
    {
        return;
    }
    printf("(");
    dfs(node[x].Lc);
    printf("%s/%d", s[node[x].key], node[x].val);
    dfs(node[x].Rc);
    printf(")");
}

int main()
{
    int n;
    while (scanf("%d", &n), n)
    {
        FOR(i, 1, n + 1)
        {
            scanf(" %[a-z]/%d", s[i], &node[i].val);
            node[i].key = i;
            // printf("%s-%d\n", s[i], node[i].val);
        }
        sort(node + 1, node + n + 1);
        node[0].val = INF;
        node[0].Lc = node[0].Rc = node[0].p = 0;
        FOR(i, 0, n + 1)
        {
            node[i].Lc = node[i].Rc = node[i].p = 0;
            insert(i);
        }
        dfs(node[0].Rc);
        printf("\n");
    }
}
```