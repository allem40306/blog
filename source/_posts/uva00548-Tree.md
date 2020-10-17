---
title: uva00548 Tree
abbrlink: 863c
date: 2020-09-18 16:15:29
category: uva
tags:
- uva
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=489)
* 題意：給一顆二元樹的中序和後序，求從根到葉節點的所有路徑中累加的最小值，輸出該葉節點的值，如果有多條路徑符合，輸出葉節點最小的一個。
<!-- more -->
* 題解：利用遞迴還原樹，後序的最後一個數字為根，藉此，我們可以找出中序的根位置，以及左右兩子樹的範圍，利用這些資訊，可以還原左有兩顆子樹。在還原過程，也可以一併算出從樹根道節點的值累加為多少。
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
vector<int> inorder, postorder;
vector<int> L, R;

bool input(vector<int> &v)
{
    string s;
    if (!getline(cin, s))
    {
        return false;
    }
    stringstream ss(s);
    v.clear();
    int x;
    while (ss >> x)
    {
        v.push_back(x);
    }
    return true;
}
int ansp, ansv;
void dfs(int L1, int R1, int L2, int R2, int sum)
{
    // cout << L1 << ' ' << R1 << ' ' << L2 << ' ' << R2 << ' ' << sum << '\n';
    int root1 = 0, root2 = R2 - 1;
    sum += postorder[root2];
    if (L1 + 1 > R1 || L2 + 1 > R2)
    {
        return;
    }
    if (L1 + 1 == R1 && L2 + 1 == R2)
    {
        if (sum <= ansv || (sum == ansv && postorder[root2 - 1] < ansv))
        {
            ansv = sum;
            ansp = postorder[root2];
        }
        return;
    }
    FOR(i, L1, R1) if (inorder[i] == postorder[root2])
    {
        root1 = i;
        break;
    }
    dfs(L1, root1, L2, L2 + (root1 - L1), sum);
    dfs(root1 + 1, R1, L2 + (root1 - L1), R2 - 1, sum);
}

int main()
{
    IOS;
    while (input(inorder))
    {
        input(postorder);
        L.resize(inorder.size());
        R.resize(inorder.size());
        ansp = ansv = INF;
        dfs(0, (int)inorder.size(), 0, (int)inorder.size(), 0);
        cout << ansp << '\n';
    }
}
```