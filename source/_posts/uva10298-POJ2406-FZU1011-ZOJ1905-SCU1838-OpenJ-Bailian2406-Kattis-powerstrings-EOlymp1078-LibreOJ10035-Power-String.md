---
title: >-
  uva10298 POJ2406 FZU1011 ZOJ1905 SCU1838 OpenJ_Bailian2406 Kattis-powerstrings
  1078 LibreOJ10035 Power String
abbrlink: 300f
date: 2020-08-17 16:50:00
category: UVa
tags:
- UVa
- POJ
- FZU
- ZOJ
- SCU
- OpenJ_Bailian
- Kattis
- EOlymp
- LibreOJ
- kmp
- hash
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1239)
[題目連結 POJ](http://poj.org/problem?id=2406)
[題目連結 FZU](http://acm.fzu.edu.cn/problem.php?pid=1011)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365404)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=1838)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/2406?lang=en_US)
[題目連結 Kattis](https://open.kattis.com/problems/powerstrings)
[題目連結 EOlymp](https://www.e-olymp.com/en/problems/1078)
[題目連結 LibreOJ](https://loj.ac/problem/10035)
* 題意：給定兩個字串 $a,b$，令 $a*b$ 為兩個字串的連接，例如 $a="123",b="456",a*b="123456"$，現在令 $a^0="",a^{n+1}=a*a^{n}$。給定一字串 $s$，求最大的 $n$ 使得 $a^n=s$。
* 注意：Kattis 字串最長 $2*10^6$，EOlymp 是 EOF 輸入，與其他 Judge 不同。
<!-- more -->
* 題解 1：利用 KMP 演算法，令字串最後一個位置為 $p$，如果 $len=p-fail[p]$ 剛好為字串長度的因數，代表 $s[p-len+1,p]=s[p-2*len+1,p-len]=...=s[0,p-x*len]$，因此 $n=\frac{字串長度}{len}$，否則 $n=1$。
```cpp=
#include <iostream>
#include <string>
using namespace std;
#define N 1000010
#define IOS                                                                    \
    cin.tie(NULL);                                                             \
    cout.tie(NULL);                                                            \
    ios_base::sync_with_stdio(false);

void bulid_fail_funtion(string B, int *fail)
{
    int len = B.length(), current_pos;
    current_pos = fail[0] = -1;
    for (int i = 1; i < len; i++)
    {
        while (current_pos != -1 && B[current_pos + 1] != B[i])
        {
            current_pos = fail[current_pos];
        }
        if (B[current_pos + 1] == B[i])
            current_pos++;
        fail[i] = current_pos;
    }
}

int main()
{
    IOS;
    string s;
    while (cin >> s, s != ".")
    {
        static int fail[N];
        bulid_fail_funtion(s, fail);
        int p = s.length() - 1;
        if (fail[p] != -1 && (p + 1) % (p - fail[p]) == 0)
            printf("%d\n", (p + 1) / (p - fail[p]));
        else
            printf("%d\n", 1);
    }
}
```
* 題解 2：先求 hash 函數，再由小到大枚舉所有字串 $s$ 長度($size$)的因數 $len$，用 Hash 函數判斷是否 $s[0,len-1]=s[len,2len-1]=...=s[xlen,size-1]$，得到第一個符合的 $len$，就輸出答案為 $\frac{size}{len}$。
```cpp=
#pragma GCC optimize(2)
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>
using namespace std;
typedef long long LL;
const int INF = 1e9;
const int MXN = 1e6 + 5;
const int MXV = 0;
const LL MOD = 10009;
const LL K = 131;
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
LL val[MXN];
char s[MXN];

LL pow2(LL x, LL y)
{
    LL res = 1;
    while (y)
    {
        if (y & 1)
        {
            res = (res * x) % MOD;
        }
        x = (x * x) % MOD;
        y >>= 1;
    }
    return res;
}

bool ok(int len, int sz)
{
    LL _pow = pow2(K, (LL)len);
    for (int i = (len << 1); i <= sz; i += len)
    {
        // cout << len << ' ' << i << ' '
        //      << (val[i] - (val[i - len] * _pow) % MOD + MOD) << ' ' << val[len]
        //      << '\n';
        if ((val[i] - (val[i - len] * _pow) % MOD + MOD) % MOD != val[len])
        {
            return false;
        }
    }
    return true;
}

int main()
{
    while (scanf("%s", s + 1), strcmp(s + 1, "."))
    {
        int sz = strlen(s + 1);
        FOR(i, 1, sz + 1) { val[i] = (val[i - 1] * K + s[i]) % MOD; }
        FOR(i, 1, sz + 1)
        {
            if (sz % i == 0 && ok(i, sz))
            {
                cout << sz / i << '\n';
                break;
            }
        }
    }
}
```