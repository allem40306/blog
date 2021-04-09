---
title: uva11234 POJ3367 HDU1805 Expressions
abbrlink: a32c
date: 2020-09-18 16:03:27
category: uva
tags:
- uva
- POJ
- HDU
- Tree
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2175)
[題目連結 POJ](http://poj.org/problem?id=3367)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=1805)
* 題意：給定一個用後綴表達式 $S$，請轉換成一個用隊列做出來會是一樣的表達式 $R$。
<!-- more -->
* 題解：先用 dfs 建樹，再 bfs 並把過程記錄，最後依 bfs 反序輸出。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>
#include <stack>
#include <queue>
#include <map>
#include <string>
#include <vector>
using namespace std;
typedef pair<int, int> PII;
typedef unsigned long long ULL;
const int INF = 1e9;
const int MXN = 1e5 + 5;
const int MXV = 3e5 + 5;
const ULL MOD = 10009;
const ULL seed = 31;
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
string s;
int si;
vector<PII> child;

int dfs()
{
    stack<int> st;
    FOR(i,0,s.size())
    {
        if(islower(s[i]))
        {
            child[i].F = child[i].S = -1;
        }
        else
        {
            child[i].S = st.top();
            st.pop();
            child[i].F = st.top();
            st.pop();

        }
        st.push(i);
    }
    return st.top();
}

vector<int> q;
void bfs(int x)
{
    q.clear();
    q.push_back(x);
    FOR(i,0,q.size())
    {
        if(child[q[i]].F!=-1)
        {
            q.push_back(child[q[i]].F);
        }
        if(child[q[i]].S!=-1)
        {
            q.push_back(child[q[i]].S);
        }
    }
    FORD(i, q.size() - 1, 0 - 1) { cout << s[q[i]]; }
    cout << '\n';
}

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        cin >> s;
        child.resize(s.size());
        si = 0;
        bfs(dfs());
    }
}
```