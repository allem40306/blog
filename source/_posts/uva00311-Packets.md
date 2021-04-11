---
title: UVa00311 Packets
abbrlink: d57d
date: 2020-08-05 22:58:57
category: UVa
tags:
- UVa
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=247)
* 題意：有個 $1\times 1, 2\times 2, ..., 6\times 6$ 的產品，各有 $R_i$ 個，問需要最小幾個 $6\times 6$ 的盒子才能裝完。
<!-- more -->
* 題解：這題沒有什麼算法，就是要對每種 size 分別去思考，順序是從大 size 到小 size。每盒最多只有一個 $4\times 4, 5\times 5, 6\times 6$ 的產品，$5\times 5$ 剩下的縫隙可以裝 $11$ 個 $1\times 1$，$4\times 4$ 可以裝 $5$ 個 $2 \times 2$ 或 $10$ 個 $1 \times 1$，$3\times 3$ 依據除 $4$ 的餘數可以再裝不同數量的 $2\times 2$ 和 $1\times 1$，$2\times 2 $ 除 $9$ 的餘數可以再裝不同數量的 $1\times 1$。我設一個變數 $leftSpace$ 來記錄還有多少空閒空間給 $1\times 1$，只不過我在 `Line 23` 把 $2\times 2$ 可以的空間也放進去，在 `Line 26` 又扣掉，這裡需特別想一下。
```cpp=
#include <functional>
#include <iostream>
#include <queue>

using namespace std;
int t[7], ans, leftSpace;
bool init()
{
    int sum = 0;
    for (int i = 1; i <= 6; ++i)
    {
        cin >> t[i];
        sum += t[i];
    }
    return sum;
}
int main()
{
    cin.tie(NULL);
    while (init())
    {
        ans = t[4] + t[5] + t[6] + (t[3] + 3) / 4; // 3 * 3 to 6 * 6
        leftSpace = t[4] * 20 + t[5] * 11; // left Space of 4 * 4 and 5 * 5

        // 2 * 2 -> 4 * 4
        leftSpace -= 4 * min(t[2], t[4] * 5);
        t[2] -= min(t[2], t[4] * 5);

        // 2 * 2 -> 3 * 3
        t[3] %= 4;
        if (t[3])
        {
            leftSpace += 36 - (t[3] * 9 + 4 * min(t[2], 7 - 2 * t[3]));
            t[2] -= min(t[2], 7 - 2 * t[3]);
        }

        // 2 * 2
        if (t[2] % 9)
        {
            leftSpace += 4 * (9 - t[2] % 9);
        }
        ans += (t[2] + 8) / 9;
        t[2] %= 9;

        // 1 * 1
        t[1] -= min(t[1], leftSpace);
        ans += (t[1] + 35) / 36;
        cout << ans << '\n';
    }
}
```