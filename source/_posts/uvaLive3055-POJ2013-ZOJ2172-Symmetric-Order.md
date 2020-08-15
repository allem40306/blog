---
title: uvaLive3055 POJ2013 ZOJ2172 Symmetric Order
abbrlink: fd34
date: 2020-08-15 16:11:45
category: UVaLive
tags:
- UVaLive
- POJ
- ZOJ
- stl
- stack
---
[題目連結 UVaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1056)
[題目連結 POJ](http://poj.org/problem?id=2013)
* 題意：給定 $N$ 個字串，要依規定輸出：先輸出奇數項字串、再反著輸出偶數項。
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365671)
<!-- more -->
* 題解：遇到奇數項直接輸出，否則用 `stack`，最後再從 `stack` 依序 `pop` 輸出。
```cpp=
#pragma GCC optimize(2)
#include <iostream>
#include <vector>
#include <string>
#include <stack>
using namespace std;
const int INF = 1e9;
const int MXN = 0;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(NULL);                                                          \
    cout.tie(NULL);                                                         \
    ios_base::sync_with_stdio(false);

int main()
{
    IOS;
    int n;
    int ti = 0;
    while(cin >> n, n)
    {
        stack<string> st;
        string s;
        cout << "SET " << ++ti << '\n';
        FOR(i, 0, n)
        {
            cin >> s;
            if(i % 2)
            {
                st.push(s);
            }
            else
            {
                cout << s << '\n';
            }
        }
        while(!st.empty())
        {
            cout << st.top() << '\n';
            st.pop();
        }
    }
}
```