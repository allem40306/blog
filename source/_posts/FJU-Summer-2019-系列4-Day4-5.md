---
title: FJU Summer 2019 系列4 Day4 5
category: 輔大
tags:
  - FJU Summer 2019
abbrlink: b2a7
date: 2019-09-18 10:00:20
---
第四天打的是2015 Phuket，題目有太多題，我就講我AC的4題好了。
<!-- more -->
* PA Hex Code
題目：將16進位轉換成10進位在輸出ASCII
解法：水題

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int T(char ch)
{
    int tmp = (isalpha(ch) ? (ch - 'A' + 10) : (ch - '0'));
    return tmp;
}

int main()
{
    string s;
    while(cin >> s)
    {
        for(int i = 0; i < (int)s.size(); i += 2)
        {
            int tmp = 16 * T(s[i]) + T(s[i + 1]);
            cout << char(tmp);
        }
        cout << '\n';
    }
}
{% endcodeblock %}

* PB Contest Strategy
題目：比賽中每個題目有花費的時間，要找出一種做題的順序，使得在時限內做出最多題且罰時最少。
解法：Greedy，由花費時間最少的題目開始做。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int T, N, L;
    vector<int> v;
    cin >> T;
    for(int ti = 1; ti <= T; ++ti)
    {
        cin >> N >> L;
        v.resize(N);
        for(int i = 0; i != N; ++i)
        {
            cin >> v[i];
        }
        sort(v.begin(), v.end());
        int tot = 0, lastT = 0, totT = 0;
        for(int i = 0; i != N; ++i)
        {
            if(lastT + v[i] > L)
            {
                break;
            }
            ++tot;
            lastT += v[i];
            totT += lastT;
        }
        cout << "Case " << ti << ": " << tot << ' ' << lastT << ' ' << totT << '\n';
    }
}
{% endcodeblock %}

* PD Aquarium
題目：水族箱被隔離了一些牆，至少要拆掉多少牆，使得所有地方都可以連通。
解法：圖論，牆的兩邊連一條邊，用最小生成樹來算要拆掉多少牆。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXV = 20005;
int par[MXV], r[MXV];
struct Edge
{
    int w;
    int x, y;
    Edge(){};
    Edge(int _w, int _x, int _y): w(_w), x(_x), y(_y){}
    bool operator<(const Edge&rhs)
    {
        return w < rhs.w;
    }
};

void init(int n)
{
    for(int i = 0; i <= n; ++i)
    {
        par[i] = i;
        r[i] = 1;
    }
}

int Find(int x)
{
    return x == par[x] ? x : par[x] = Find(par[x]);
}

bool Union(int x, int y)
{
    // cout << x << ' ' << y << '\n';
    x = Find(x);
    y = Find(y);
    if(x == y)
    {
        return false;
    }
    if(r[x] == r[y])
    {
        par[y] = x;
        ++r[x];
    }
    else if(r[x] > r[y])
    {
        par[y] = x;
    }
    else
    {
        par[x] = y;
    }
    return true;
}

int main()
{
    int t, n, m;
    string s[105];
    vector<Edge> v;
    cin >> t;
    for(int ti = 1; ti <= t; ++ti)
    {
        cin >> n >> m;
        init(2 * n * m);
        for(int i = 0; i != n; ++i)
        {
            cin >> s[i];
        }
        for(int i = 1; i != n; ++i)for(int j = 0; j != m; ++j)
        {
            int no1 = 2 * ((i - 1) * m + j) + (s[i - 1][j] == '/');
            int no2 = 2 * ((i) * m + j) + (s[i][j] == '\\');
            Union(no1, no2);
        }
        v.clear();
        for(int i = 0, w; i != n; ++i)for(int j = 0; j != m; ++j)
        {
            cin >> w;
            v.push_back(Edge(w, 2 * (i * m + j), 2 * (i * m + j) + 1));
            if(j)
            {
                Union(2 * (i * m + j), 2 * (i * m + j) - 1);
            }
        }
        sort(v.begin(), v.end());
        int ans = 0;
        for(int i = 0; i != (int)v.size(); ++i)
        {
            if(Union(v[i].x, v[i].y))
            {
                ans += v[i].w;
            }
        }
        cout << "Case " << ti << ": " << ans << '\n';
    }
}
{% endcodeblock %}

* PL Donation Packaging
題目：每天都會收到三種數量不一的捐證物，如果每種數量都$<=30$，就把3種東西捐一樣數量，數量為三種當中最少的。
解法：水題
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int D, a, b, c;
    int tota = 0, totb = 0, totc = 0;
    cin >> D;
    while(D--)
    {
        cin >> a >> b >> c;
        tota += a;
        totb += b;
        totc += c;
        int mn = min(tota, min(totb, totc));
        if(mn < 30)
        {
            cout << "NO\n";
        }
        else
        {
            cout << mn << '\n';
            tota -= mn;
            totb -= mn;
            totc -= mn; 
        }
        
    }
}
{% endcodeblock %}

晚上就講NCPC2018和flow，然後講師說最後兩天可以下午上課，晚上上機，我們就答應了。

第五天下午打的是NPSC某一年決賽，被電爛所以沒AC任何一題，晚上講的是Math，前面講排列組合，後面講質數，我覺得都還能接受，只是搞不懂n相同球放n相同箱子的組合數。