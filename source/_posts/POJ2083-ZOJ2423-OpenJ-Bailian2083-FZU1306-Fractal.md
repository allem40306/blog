---
title: POJ2083 ZOJ2423 OpenJ_Bailian2083 FZU1306 Fractal
abbrlink: '7525'
date: 2020-08-15 16:22:38
category: POJ
tags:
- POJ
- ZOJ
- OpenJ_Bailian
- FZU
- 遞迴
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 POJ](http://poj.org/problem?id=2083)
[題目連結 ZOJ](https://zoj.pintia.cn/problem-sets/91827364500/problems/91827365922)
[題目連結 OpenJ_Bailian](http://bailian.openjudge.cn/practice/2083?lang=en_US)
[題目連結 FZU1306](http://acm.fzu.edu.cn/problem.php?pid=1306)
* 題意：令 $B(1)=X$，$B(n)=$![](https://i.imgur.com/sP5uXtK.png)，求 $B(n),(1\leq n\leq 7)$
<!-- more -->
* 題解：先找出中心點，再從中心點遞迴到 $B(n-1)$ 的中心點，$n=1$ 時就在該位置填 $X$。需要處理行尾會多輸出空白的問題，求出答案後，把行末空白用星號表示，輸出時遇到空白就跳出迴圈。
```cpp=
#include <cmath>
#include <cstring>
#include <iostream>
#include <vector>

using namespace std;
const int N = 731;
char ans[N][N];

void print(int n, int x, int y)
{
    if (n == 1)
    {
        ans[x][y] = 'X';
        return;
    }
    int m = pow(3.0, n - 2);
    print(n - 1, x, y);
    print(n - 1, x + m, y + m);
    print(n - 1, x + 2 * m, y + 2 * m);
    print(n - 1, x, y + 2 * m);
    print(n - 1, x + 2 * m, y);
}

int main()
{
    int n;
    while (cin >> n, n != -1)
    {
        int m = pow(3.0, n - 1);
        for (int i = 0; i < m; ++i)
        {
            for (int j = 0; j < m; ++j)
            {
                ans[i][j] = ' ';
            }
        }
        print(n, 0, 0);
        for (int i = 0; i < m; ++i)
        {
            for (int j = m - 1; j >= 0; --j)
            {
                if (ans[i][j] == ' ')
                {
                    ans[i][j] = '*';
                }
                else
                {
                    break;
                }
            }
        }
        for (int i = 0; i < m; ++i)
        {
            for (int j = 0; j < m; ++j)
            {
                if (ans[i][j] == '*')
                {
                    break;
                }
                printf("%c", ans[i][j]);
            }
            printf("\n");
        }
        printf("-\n");
    }
}
```