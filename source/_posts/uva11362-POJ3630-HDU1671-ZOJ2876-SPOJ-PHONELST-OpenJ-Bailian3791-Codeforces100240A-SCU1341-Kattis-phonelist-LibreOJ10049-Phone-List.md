---
title: >-
  uva11362 POJ3630 HDU1671 ZOJ2876 SPOJ-PHONELST OpenJ_Bailian3791
  Codeforces100240A SCU1341 Kattis-phonelist LibreOJ10049 Phone List
abbrlink: fac0
date: 2020-08-21 17:06:00
category: UVa
tags:
- UVa
- POJ
- HDU
- ZOJ
- SPOJ
- OpenJ_Bailian
- Codeforces
- SCU
- Kattis
- LibreOJ
- trie
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2347)
[題目連結 POJ](http://poj.org/problem?id=3630)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=1671)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827366374)
[題目連結 SPOJ](https://www.spoj.com/problems/PHONELST/en/)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/3791?lang=en_US)
[題目連結 Codeforces](https://codeforces.com/gym/100240/attachments)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=3141)
[題目連結 Kattis](https://open.kattis.com/problems/phonelist)
[題目連結 LibreOJ](https://loj.ac/problem/10049)
* 題意：給定一本電話簿有多個電話號碼，問這些電話號碼是否合法。合法定義為對於任兩組電話，互不為對話的前綴。
<!-- more -->
* 題解：用 `trie` 紀錄每一種字串，是多少字串的前綴，接著搜尋答案時，如果發現該字串為別人的前綴時，就得知這本電話簿不合法。
* 心得：EOlymp2303 和 OpenJ_Bailian4089 無法通過。
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
const int MXN = 1e5 + 5;
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
bool ok;

struct Node
{
    int i;
    char ch;
    int v;
    Node *next[10];
    void init(char _ch = '\0')
    {
        v = 0;
        FOR(i, 0, 10) next[i] = NULL;
    }
    Node() { init(); }
} node[MXN];
int nodei;
char s[MXN][15];

void insert(Node *root, string s)
{
    FOR(i, 0, s.size())
    {
        int v = s[i] - '0';
        if (root->next[v] == NULL)
        {
            root->next[v] = &node[++nodei];
            root->next[v]->init();
        }
        root = root->next[v];
        root->ch = s[i];
        ++root->v;
    }
    return;
}

void search(Node *root, string s)
{
    FOR(i, 0, s.size())
    {
        int v = s[i] - '0';
        root = root->next[v];
    }
    if (root->v > 1)
    {
        ok = false;
    }
}

int main()
{
    FOR(i, 0, MXN) { node[i].i = i; }
    int t;
    scanf("%d", &t);
    while (t--)
    {
        int n;
        Node *root = &node[0];
        scanf("%d", &n);
        root->init();
        nodei = 0;
        FOR(i, 0, n)
        {
            scanf("%s", s[i]);
            insert(root, s[i]);
        }
        ok = true;
        FOR(i, 0, n)
        {
            search(root, s[i]);
            if (!ok)
            {
                break;
            }
        }
        if (ok)
        {
            printf("YES\n");
        }
        else
        {
            printf("NO\n");
        }
    }
}
```