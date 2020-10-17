---
title: POJ2255 OpenJ_Bailian2255 ZOJ1944 HRBUST2022 Tree Recovery
abbrlink: e031
date: 2020-09-18 16:19:15
category: POJ
tags:
- POJ
- OpenJ_Bailian
- ZOJ
- HRBUST
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=2255)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/2255?lang=en_US)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365443)
[題目連結 HRBUST](http://acm.hrbust.edu.cn/index.php?m=ProblemSet&a=showProblem&problem_id=2022)
* 題意：給定一顆二元樹的前序和中序，求其後序。
<!-- more -->
* 題解：前序第一個為根，藉此可以找出中序的根和左右子樹的範圍。依序訪問左子樹、右子樹，並輸出根，就可以得到後序。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>
#include <map>
#include <string>
#include <vector>
using namespace std;
typedef long long LL;
const int INF = 1e9;
const int MXN = 1e5 + 5;
const int MXV = 3e5 + 5;
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

string preorder, inorder;
void dfs(int L1, int R1, int L2, int R2)
{
    // cout << L1 << ' ' << R1 << ' ' << L2 << ' ' << R2 << '\n';
    int root1 = L1, root2 = 0;
    if (L1 + 1 > R1 || L2 + 1 > R2)
    {
        return;
    }
    if (L1 + 1 == R1 && L2 + 1 == R2)
    {
        cout << preorder[L1];
        return;
    }
    FOR(i, L2, R2) if (preorder[root1] == inorder[i])
    {
        root2 = i;
        break;
    }
    dfs(L1 + 1, L1 + 1 + (root2 - L2), L2, root2);
    dfs(L1 + 1 + (root2 - L2), R1, root2 + 1, R2);
    cout << preorder[root1];
}

int main()
{
    IOS;
    while (cin >> preorder >> inorder)
    {
        dfs(0, (int)inorder.size(), 0, (int)inorder.size());
        cout << '\n';
    }
}
```