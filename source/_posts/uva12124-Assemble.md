---
title: UVa12124 Assemble
abbrlink: '1e46'
date: 2020-07-24 15:00:40
category: UVa
tags:
- UVa
- Binary Search
- STL
- Map
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3276)
* 題意：給定 $N$ 個 copoment 和預算 $b$，要求每種 copoment 都使用的情況下，所組出的電腦品質最高可為多少，電腦品質為所有被選到的 copoment 的品質最小值。
<!-- more -->
* 題解：這題要用二分搜來解。一開始先將 copoment 依 type 分類，這裡利用 map，來把字串轉化成 `ID`。判斷品質為 $x$ 的情況下，是否能在預算 $b$ 以內達成的作法為，取每一種 copoment 品質 $>=x$ 中預算最小的加進 $sum$，看看總和有沒有超過 $b$，要是有某種 copoment 品質沒有 $>=x$ 的情況，就讓 $sum+=b+1$，這樣的話 $x$ 一定不能當作解答。

```cpp=
#pragma GCC optimize("O2")
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
using PII = pair<int, int>;
using PLL = pair<LL, LL>;
const int INF = 1e9;
const int MXN = 1e3 + 5;
const int MXV = 0;
#define MP make_pair
#define PB push_back
#define F first
#define S second
#define FOR(i, L, R) for (int i = L; i != (int)R; ++i)
#define FORD(i, L, R) for (int i = L; i != (int)R; --i)
#define IOS                                                                    \
    cin.tie(nullptr);                                                          \
    cout.tie(nullptr);                                                         \
    ios_base::sync_with_stdio(false);
LL b;

struct Type
{
    LL price;
    int quality;
};

vector<Type> v[MXN];
map<string, int> typeId;
int id;

int getTypeId(string type)
{
    if(typeId.find(type) == typeId.end())
    {
        typeId.insert({type, ++id});
    }
    return typeId[type];
}

vector<Type> types[MXN];

bool ok(int x)
{
    // cout << "test " << x << '\n';
    LL sum = 0;
    FOR(i, 0, id + 1)
    {
        LL mn = b + 1;
        for(Type type: types[i])
        {
            if(type.quality >= x)
            {
                mn = min(mn, type.price);
            }
        }
        sum += mn;
        // cout << "type " << i << ": " << mn << '(' << sum << ')' << '\n';
    }
    return sum <= b;
}

int main()
{
    IOS;
    int t;
    cin >> t;
    while (t--)
    {
        int n;
        cin >> n >> b;
        FOR(i, 0, n) { types[i].clear(); }
        id = -1;
        typeId.clear();
        int maxq = 0;
        FOR(i, 0, n)
        {
            string type, name;
            int price, quality;
            cin >> type >> name >> price >> quality;
            types[getTypeId(type)].push_back(Type{price, quality});
            maxq = max(maxq, quality);
        }
        int L = 0, R = maxq;
        while(L != R)
        {
            int M = (L + R + 1) >> 1;
            if(ok(M))
            {
                L = M;
            }
            else
            {
                R = M - 1;
            }
        }
        cout << L << '\n';
    }
}
```