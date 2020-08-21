---
title: POJ3889 SCU3788 Codeforces101518G Fractal Streets
abbrlink: 63e
date: 2020-08-15 16:20:44
category: POJ
tags:
- POJ
- SCU
- Codeforces
- 遞迴
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=3889)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=3788)
[題目連結 Codeforces](https://codeforces.com/gym/101518/attachments)
* 題意：新城鎮的房子都依照下圖中的規律編號，現在有 $n\times n$ 棟房子，給你兩棟房子的編號，問他們相差多遠(先取歐式距離在乘以 $10$)。
<!-- more -->
* ![](https://i.imgur.com/G7mwXsy.png)
* 題解：遞迴算出座標，每次把房子切 4 分(左上、左下、右上、右下)，算出是在 $m\times m$ 的哪一塊，之後遞迴 $m-1\times m-1$，直到 $1\times 1$，之後從 $m-1\times m-1$ 反推到 $m\times m$ 的座標依樣分成 4 的部分討論，注意到左上和左下有旋轉。
    * 左上：$(x,y)\to(y,x)$
    * 右下：$(x,y)\to(x,y+2^{n-1})$
    * 右下：$(x,y+2^{n-1})\to(x,y+2^{n-1})$
    * 左下：$(x,y)\to(2^{n-1}-y-1,2^{n-1}-x-1)$
```cpp=
#include <cmath>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <vector>

using namespace std;
typedef long long LL;

void calc(int n, int id, LL &x, LL &y)
{
    if (n == 1)
    {
        if (id == 1)
        {
            x = 1;
            y = 1;
        }
        else if (id == 2)
        {
            x = 1;
            y = 2;
        }
        else if (id == 3)
        {
            x = 2;
            y = 2;
        }
        else if (id == 4)
        {
            x = 2;
            y = 1;
        }
        // cout << n << ' ' << x << ' ' << y << '\n';
        return;
    }
    LL _id = (1 << (n - 1)) * (1 << (n - 1));
    if (id <= _id)
    {
        calc(n - 1, id, y, x); // rotate
    }
    else if (id <= 2 * _id)
    {
        calc(n - 1, id - _id, x, y);
        y += (1 << (n - 1)); // y -> 2^(n-1) + y
    }
    else if (id <= 3 * _id)
    {
        calc(n - 1, id - 2 * _id, x, y);
        x += (1 << (n - 1)); // x -> 2^(n-1) + x
        y += (1 << (n - 1)); // y -> 2^(n-1) + y
    }
    else if (id <= 4 * _id)
    {
        calc(n - 1, id - 3 * _id, y, x); // rotate
        x = (1 << n) + 1 - x;            // x -> 2^n+1-x
        y = (1 << (n - 1)) + 1 - y;      // x -> 2^(n-1)+1-y
    }
    // cout << n << ' ' << x << ' ' << y << '\n';
}

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        LL n, a, b;
        LL x1, x2, y1, y2;
        cin >> n >> a >> b;
        calc(n, a, x1, y1);
        calc(n, b, x2, y2);
        x1 -= x2;
        y1 -= y2;
        cout << fixed << setprecision(0) << sqrt((double)(x1 * x1 + y1 * y1)) * 10
             << '\n';
    }
}
```