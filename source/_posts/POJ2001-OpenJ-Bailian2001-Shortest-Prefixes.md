---
title: POJ2001 OpenJ_Bailian2001 Shortest Prefixes
abbrlink: e7a4
date: 2020-08-21 17:04:55
category: POJ
tags:
- POJ
- Trie
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=2001)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/2001?lang=en_US)
* 題意：給定一些字串，要幫每個字串找到最短的縮寫，一個合法的縮寫為該縮寫不能為別人的前綴，如果該字串本身就是別人的前綴，那麼最短縮寫就是該字串本身。
<!-- more -->
* 題解：用 `trie` 紀錄每一種字串，是多少字串的前綴，接著搜尋答案時，枚舉字串前綴，一發現某前綴只是該字串的前綴時，就輸出答案，如果找不到，就輸出該字串本身。
* 心得：ZOJ 和 UvaLive 有 $t$ 行板的版本，但我過不了。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <bitset>
#include <cmath>
#include <cstring>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <vector>
using namespace std;
typedef pair<int, int> PII;
typedef long long LL;
const int INF = 1e9;
const int MXN = 1e3 + 5;
const int MXV = 1e5 + 5;
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

struct Node
{
    char ch;
    int v;
    Node *next[26];
    Node()
    {
        v = 0;
        FOR(i, 0, 26) next[i] = NULL;
    }
};

void insert(Node *root, string s)
{
    FOR(i, 0, s.size())
    {
        int v = s[i] - 'a';
        if (root->next[v] == NULL)
        {
            root->next[v] = new Node();
        }
        root = root->next[v];
        ++root->v;
        root->ch = s[i];
    }
    return;
}
void search(Node *root, string s)
{
    FOR(i, 0, s.size())
    {
        int v = s[i] - 'a';
        root = root->next[v];
        if (root->v == 1)
        {
            cout << s << ' ' << s.substr(0, i + 1) << '\n';
            return;
        }
    }
    cout << s << ' ' << s << '\n';
}

int main()
{
    vector<string> v;
    string s;
    Node *root = new Node();
    while (cin >> s)
    {
        insert(root, s);
        v.push_back(s);
    }
    FOR(i, 0, v.size()) { search(root, v[i]); }
}
```