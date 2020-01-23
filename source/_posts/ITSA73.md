---
title: ITSA73
category: ITSA
tags:
  - bfs
  - dfs
  - ITSA
abbrlink: e028
date: 2019-08-20 10:56:11
---
總共這次ITSA有9題，不知道下次會變幾題?
答對題目：123 567
還沒AC的題目之後有空再補
<!-- more -->
P1
要把`N`個整數先依照數字的個位數和排序，再依照數值排序。
做法：用`pair`存位數和本身數值在排序即可。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int f(int x)
{
    int res = 0;
    while(x)
    {
        res += x % 10;
        x /=10;
    }
    return res;
}

int main()
{
    int n;
    vector<pair<int, int>> v;
    cin >> n;
    for(int i = 0, x, y; i != n; ++i)
    {
        cin >> x;
        y = f(x);
        v.push_back({y, x});
    }
    sort(v.begin(), v.end());
    for(int i = 0; i != n; ++i)
    {
        cout << v[i].second << " \n"[i == n - 1];
    }
}
{% endcodeblock %}

P2
給定兩複數，求出它們加減乘法的結果。
做法：知道什麼是複數就可以做了，浮點數輸出我用`printf`做比較方便。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    double a, b, c, d;
    cin >> a >> b >> c >> d;
    printf("(%.2f)+(%.2f)i\n", a + c, b + d);
    printf("(%.2f)+(%.2f)i\n", a - c, b - d);
    printf("(%.2f)+(%.2f)i\n", a * c - b * d, a * d + b * c);
    
}
{% endcodeblock %}

P3
求`N`點到`M`點之間，所有時針和分針角度差介於88到92度之間的時刻。
做法：枚舉每一分，令時間為`hh:mm`，分針角度為6*`mm`，時間角度為`30*hh+mm*0.5`，這樣就能判定角度差多少了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

void Test(int i, int j)
{
    double x = double(i % 12) * 30.0 + double(j) * 0.5;
    double y = double(j) * 6;
    // cout << i << ' ' << j << ' ' << x << ' ' << y << '\n';
    double mn = min(abs(x - y), 360 - abs(x - y));
    if(88.0 <= mn && mn <= 92.0)
    {
        printf("%.2d:%.2d degree=%.2f\n", i, j, mn);
    }
}

int main()
{
    int L, R;
    while(cin >> L >> R)
    {
        for(int i = L; i != R; ++i)
        {
            for(int j = 0; j != 60; ++j)
            {
                Test(i, j);
            }
        }
        Test(R, 0);
    }
}
{% endcodeblock %}

P5
給定`M*N`的矩陣，`0`代表走道，其他代表土地，問有幾塊土地相連(上下左右)，以及最大數字總和的土地為何。
做法：用BFS或DFS，並將每一塊土地的數字總和寄在`vector`裡。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 105;
int m, n;
int a[MXN][MXN];
queue<pair<int, int>> q;
vector<int> v;
int dx[4] = {-1, 0, 1, 0};
int dy[4] = {0, 1, 0, -1};

void bfs(int sx, int sy)
{
    int tot = a[sx][sy]; a[sx][sy] = 0;
    while(!q.empty())
    {
        q.pop();
    }
    q.push({sx, sy});
    while(!q.empty())
    {
        auto k = q.front(); q.pop();
        for(int i = 0; i != 4; ++i)
        {
            int x = k.first + dx[i];
            int y = k.second + dy[i];
            if(x < 0 || x > m || y < 0 || y > n || a[x][y] == 0)
            {
                continue;
            }
            tot += a[x][y];
            a[x][y] = 0;
            q.push({x, y});
        }
    }
    v.push_back(tot);
    return;
}

int main()
{
    while(cin >> n >> m)
    {
        v.clear();
        for(int i = 0; i < m; ++i)
        {
            for(int j = 0; j < n; ++j)
            {
                cin >> a[i][j];
            }
        }
        for(int i = 0; i < m; ++i)
        {
            for(int j = 0; j < n; ++j)
            {
                if(a[i][j])
                {
                    bfs(i, j);
                }
            }
        }
        sort(v.begin(), v.end());
        cout << v.size() << '\n' << v[v.size() - 1] << '\n'; 
    }
}
{% endcodeblock %}

P6
給定N個人的年收入資料，對前`10%, 30%, 60%, 80%`分別課`40%, 30%, 20%, 10%`的課金，如果收入一樣就算同一區間，求總共可以收多少稅金。
做法：算出第`10%, 30%, 60%, 80%`的人他的年收入，在算出每個人在哪一個區間，最後統計答案即可。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
double range[4] = {0.1, 0.3, 0.6, 0.8};
double radio[4] = {0.4, 0.3, 0.2, 0.1};
int main()
{
    int t, n;
    vector<int> v;
    cin >> t;
    while(t--)
    {
        cin >> n;
        v.resize(n);
        for(int i = 0; i != n; ++i)
        {
            cin >> v[i];
        }
        sort(v.begin(), v.end(), greater<int>());
        int vi = 0, ans = 0;
        for (int i = 0; i < 4; ++i)
        {
            while(vi != n && v[vi] >= v[floor(double(n) * range[i])])
            {
                ans += ceil(double(v[vi]) * radio[i]);
                ++vi;
            }
        }
        cout << ans << '\n';
    }
}
{% endcodeblock %}

P7
給定一張`N*N`的圖及`k`個障礙，最後給定一個點，問從那個點移動，可以去多少個位置。
做法：用BFS或DFS即可
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 105;
int n;
int a[MXN][MXN];
queue<pair<int, int>> q;
int dx[4] = {-1, 0, 1, 0};
int dy[4] = {0, 1, 0, -1};

int bfs(int sx, int sy)
{
    int ans = 1; a[sx][sy] = 1;
    while(!q.empty())
    {
        q.pop();
    }
    q.push({sx, sy});
    while(!q.empty())
    {
        auto k = q.front(); q.pop();
        // cout << k.first << ' ' << k.second << '\n';
        for(int i = 0; i != 4; ++i)
        {
            int x = k.first + dx[i];
            int y = k.second + dy[i];
            if(x < 0 || x >= n || y < 0 || y >= n || a[x][y] == 1)
            {
                continue;
            }
            ++ans;
            a[x][y] = 1;
            q.push({x, y});
        }
    }
    return ans;
}

int main()
{
    int t, k;
    cin >> t;
    while(t--)
    {
        cin >> n >> k;
        memset(a, 0, sizeof(a));
        for(int i = 0, x, y; i < k; ++i)
        {
            cin >> x >> y;
            --x; --y;
            a[x][y] = 1;
        }
        int sx, sy;
        cin >> sx >> sy;
        --sx; --sy;
        cout << bfs(sx, sy) << '\n'; 
    }
}
{% endcodeblock %}