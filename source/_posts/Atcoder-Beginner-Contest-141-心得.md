---
title: Atcoder Beginner Contest 141 心得
category: AtCoder
tags:
  - AtCoder
  - greedy
  - string
abbrlink: ec59
date: 2019-10-08 10:01:18
---
這場比賽自評覺得不錯，除了最後一題之外都有寫出來。
<!-- more -->
* PA Weather Prediction([ABC 141A](https://atcoder.jp/contests/abc140/tasks/abc141_a))
題目：狀態會由`Sunny, Cloudy, Rainy, Sunny...`三個輪由替換，給你目前狀態，請輸出下個狀態。
解法：if條件判斷

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    string s;
    cin >> s;
    if(s == "Sunny")
    {
        cout << "Cloudy\n";
    }
    else if(s == "Cloudy")
    {
        cout << "Rainy\n";
    }
    else
    {
        cout << "Sunny\n";
    }
    
}
{% endcodeblock %}

* PB Tap Dance([ABC 141A](https://atcoder.jp/contests/abc140/tasks/abc141_b))
題目：一支舞的奇數步不能有`L`，偶數步不能有`R`，請你檢查有沒有合乎規定。
解法：if條件判斷

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main()
{
    bool ok = true;
    string s;
    cin >> s;
    for(int i = 0; i != (int)s.size(); ++i)
    {
        if(i & 1)
        {
            if(s[i] == 'R')
            {
                ok = false;
            }
        }
        else
        {
            if(s[i] == 'L')
            {
                ok = false;
            }
        }
    }
    cout << (ok ? "Yes\n" : "No\n");
}
{% endcodeblock %}

* PC Attack Survival([ABC 141C](https://atcoder.jp/contests/abc140/tasks/abc141_c))
題目：一場益智問答，一人答對題目，其他人扣分，給你每個人的初始分數$K$還有答題情形，問最後誰分數$>0$
解法：題數-答對題數=每個人扣的分數，拿來和$k$比較大小。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 100005;

int main()
{
    int n, k, q;
    int a[MXN] = {};
    cin >> n >> k >> q;
    for(int i = 0, x; i < q; ++i)
    {
        cin >> x;
        ++a[x];
    }
    for(int i = 1; i <= n; ++i)
    {
        cout << (k - (q - a[i]) > 0 ? "Yes\n" : "No\n");
    }
}
{% endcodeblock %}

* PD Powerful Discount Tickets([ABC 141D](https://atcoder.jp/contests/abc140/tasks/abc141_d))
題目：有$N$項商品和$M$張折價券，每張折價券可讓一項商品價格除以2，問最少要付多少錢。
解法：Greedy，每次將最貴的價錢/2，用`priority_queue`維護當前最高價格的物品。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
using LL = long long;

int main()
{
    int n, m;
    LL x;
    priority_queue<LL> pq;
    cin >> n >> m;
    for(int i = 0; i < n; ++i)
    {
        cin >> x;
        pq.push(x);
    }
    for(int i = 0; i < m; ++i)
    {
        x = pq.top(); pq.pop();
        pq.push(x / 2);
    }
    LL ans = 0;
    for(int i = 0; i < n; ++i)
    {
        ans += pq.top(); pq.pop();
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PE Who Says a Pun?([ABC 141E](https://atcoder.jp/contests/abc140/tasks/abc141_e))
題目：給定一個字串，要你求出所有不重疊且相等的兩區間之中，最長為多少。
解法：字串匹配，枚舉第一個區間開頭，用`Z algorithm`算出能匹配到的最長區間。這題還有其他字串匹配演算法可以做出來，可以去搜尋別人的程式。

{% codeblock lang:cpp %}
/*
source: Atcoder 141 E
*/
#include <bits/stdc++.h>
using namespace std;
const int MXN = 5005;
int ans = 0;
int z[MXN];

void z_value(string s){
	int L = 0, R = 0;
	z[0] = 0;
	for (int i = 1; i < (int)s.size(); i++){
		if (i > R)
        {
            z[i] = 0;
        }
        else{
			int ip = i - L;
			if (ip + z[ip] < z[L])
            {
                z[i] = z[ip];
            }
			else
            {
                z[i] = R - i + 1;
            } 
		}
		while (i + z[i] < (int)s.size() && s[i + z[i]] == s[z[i]])
        {
            z[i]++;
        }
		if (i + z[i] - 1 > R){
			L = i;
			R = L + z[i] - 1;
		}
        ans = max(ans, (i > z[i] ? z[i] : i));
	}
}

int main()
{
    int n;
    string s;
    cin >> n >> s;
    ans = -1;
    for(int i = 0; i < n; ++i)
    {
        z_value(s.substr(i));
    }
    cout << ans << '\n';
}
{% endcodeblock %}
* PF Xor Sum 3([ABC 141F](https://atcoder.jp/contests/abc140/tasks/abc141_f))
題目：要你把數字分兩堆，求出兩堆分別xor和最大值。
解法：如果有偶數個數字的第$i$位元是1，那該位元兩堆都要是1才會最大。如果有奇數個數字的第$i$位元是1，那麼分在哪堆都可以。
[相關連結](https://www.geeksforgeeks.org/find-maximum-subset-xor-given-set/)

{% codeblock lang:cpp %}
/*
source: ABC 141 F Xor Sum 3
*/
#include <bits/stdc++.h>
using namespace std;
using LL = long long;
const int MXN = 100005;

int main(){
    int n;
    LL a[MXN], b[MXN], sum = 0;
    memset(a, 0, sizeof(a));
    memset(b, 0, sizeof(b));
    cin >> n;
    for(int i = 0; i < n; ++i)
    {
        cin >> a[i];
        sum ^= a[i];
    }
    for(int i = 0; i < n; ++i)
    {
        a[i] &= (~sum);
        for(int j = 60; j >= 0; --j)
        {
            if((a[i] >> j) & 1)
            {
                if(b[j] == 0)
                {
                    b[j] = a[i];
                    break;
                }
                else
                {
                    a[i] ^= b[j];
                }
            }
        }
    }
    LL x = 0;
    for(int i = 60; i >= 0; --i)
    {
        x = max(x, x ^ b[i]);
    }
    cout << (x + (x ^ sum)) << '\n';
}
{% endcodeblock %}

