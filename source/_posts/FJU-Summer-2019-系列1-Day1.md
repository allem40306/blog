---
title: FJU Summer 2019 系列1 Day1
date: 2019-09-12 22:42:32
category: 輔大
tags:
- FJU
---
每年暑假最後一個禮拜，系上都會辦為期一個禮拜的訓練營，會請外面的講師來授課，這次的講師是去年的講師，加上他找來的兩個人，都是程式競賽中的佼佼者。今年的模式是下午上機，晚上上課。
第一天下午是在VJudge上打AtCoder的題目。
* PA Foods Loved by Everyone([ABC 118B](https://abc118.contest.atcoder.jp/tasks/abc118_b?lang=en))
題目：問有幾個食物是被大家都喜歡。
解法：用array做一做就出來了。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 50;

int main(){
    int n, m;
    int cnt[MXN] = {};
    cin >> n >> m;
    for(int i = 0, k, a; i != n; ++i)
    {
        cin >> k;
        while(k--)
        {
            cin >> a;
            ++cnt[a];
        }
    }
    int ans = 0;
    for(int i = 0; i <= m; ++i)
    {
        if(cnt[i] == n)
        {
            ++ans;
        }
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PB Collatz Problem([ABC116 B](https://abc116.contest.atcoder.jp/tasks/abc116_b?lang=en))
題意：給一序列第一項$a_1=s$, $a_n=F(a_{n-1})$, $f(n)=n/2$ if $n$ is odd, $f(n)=3n+1$ if $n$ is even, 問第幾項會開始進入循環。
解法：用set紀錄之前出現過的數字，如果遇到重複的話就輸出答案。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
set<int> tb;

int main(){
    int n, stamp = 1;
    cin >> n;
    while(tb.find(n) == tb.end())
    {
        ++stamp;
        tb.insert(n);
        if(n & 1)
        {
            n = 3 * n + 1;
        }
        else
        {
            n = n / 2;
        }
    }
    cout << stamp << '\n';
}
{% endcodeblock %}

* PC GCD on Blackboard([ABC 125C](https://abc125.contest.atcoder.jp/tasks/abc125_c?lang=en))
題意：給定一個長度為$N$序列，可以改變一個數字的值，使所有數字的GCD最大。
解法：改的數字的值要是其他數字GCD的倍數，於是就可以枚舉任意$N-1$個數字的GCD取max，時間複雜度$O(N^2)$ TLE，然而我們可以用前綴和和後綴和加速查詢，時間複雜度降到$O(N)$。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 100005;
int a[MXN], pre[MXN], pos[MXN];

int main(){
    int n;
    cin >> n;
    for(int i = 1; i <= n; ++i)
    {
        cin >> a[i];
    }
    pre[1] = a[1];
    pos[n] = a[n];
    for(int i = 2; i <= n; ++i)
    {
        pre[i] = __gcd(pre[i - 1], a[i]);
    }
    for(int i =n - 1; i > 1; --i)
    {
        pos[i] = __gcd(pos[i + 1], a[i]);
    }
    int ans = max(pre[n - 1], pos[2]);
    for(int i = 2; i != n; ++i)
    {
        ans = max(ans, __gcd(pre[i - 1], pos[i + 1]));
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PD Streamline([ABC 117C](https://abc117.contest.atcoder.jp/tasks/abc117_c?lang=en))
題意：有$N$支旗子要放置在直線上的任一地點，並且要用那些旗子遍歷過$M$的地點，求旗子最小移動總和。
解法：讓每支各別負責一段區間，求最小區間總和，我們可以改求那些區間的"間隔"最大，再將總長度減去"間隔"即為答案。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main(){
    int n, m;
    vector<int> v, dis;
    cin >> n >> m;
    v.resize(m);
    for(int i = 0; i != m; ++i)
    {
        cin >> v[i];
    }
    sort(v.begin(), v.end());
    for(int i = 1; i != m; ++i)
    {
        dis.push_back(v[i] - v[i - 1]);
    }
    sort(dis.begin(), dis.end());
    int ans = 0;
    for(int i = 0; i < (int)dis.size() - n + 1; ++i)
    {
        ans += dis[i];
    }
    cout << ans << '\n';
}
{% endcodeblock %}

* PE Flipping Signs([ABC 125D](https://abc125.contest.atcoder.jp/tasks/abc125_d?lang=en))
題意：給定一個序列，和一個可以將相鄰兩數$\times -1$的操作，問最後總和最大值
解法：我一開始用DP，後來聽講解發現有更快解法。我定義dp式為前i個數總和最大值，其中最後一個數字正或負(0/1)。至於另一個做法，觀察後發現，如果原本有偶數的負號，最後可以完全消除，有奇數的負號，最後可以只剩一個，因此可以先判斷負號個數，如果是奇數個負號，就挑一個絕對值做小的數字當負數，最後再加種起來就好了。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 100005;
using LL = long long;
LL a[MXN], dp[MXN][2];

int main(){
    int n;
    cin >> n;
    for(int i = 1; i <= n; ++i)
    {
        cin >> a[i];
    }
    if(a[2] >= 0)
    {
        dp[2][0] = (a[1] + a[2]);
        dp[2][1] = -(a[1] + a[2]);
    }
    else
    {
        dp[2][0] = -(a[1] + a[2]);
        dp[2][1] = (a[1] + a[2]);
    }
    for(int i = 3; i <= n; ++i)
    {
        if(a[i] >= 0)
        {
            dp[i][0] = max(dp[i - 1][0], dp[i - 1][1]) + a[i];
            dp[i][1] = max(dp[i - 1][0] - 2 * abs(a[i - 1]), dp[i - 1][1] + 2 * abs(a[i - 1])) - a[i];
        }
        else
        {
            dp[i][0] = max(dp[i - 1][0] - 2 * abs(a[i - 1]), dp[i - 1][1] + 2 * abs(a[i - 1])) - a[i];
            dp[i][1] = max(dp[i - 1][0], dp[i - 1][1]) + a[i];
        }
    }
    cout << max(dp[n][0], dp[n][1]) << '\n';
}
{% endcodeblock %}

* PF 1 or 2([ABC 126E](https://abc126.contest.atcoder.jp/tasks/abc126_e?lang=en))
題意：給定$N$張牌，上面只有1或2，以及$M$筆資訊，上面內容為第$x$張牌$+$第$y$張牌+$Z$為偶數，問最少要知道幾張牌的值才能知道其他張。
解法：每筆資訊指只要知道一張牌的值，就可以知道另一張牌的值，任意兩筆資訊如果有一樣的牌，只要知道一個，就可以知道其他張牌，依據這個性質，就可以用並查集來做，合併每筆資訊的兩張牌，最後算有幾個連通塊就是答案。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int MXN = 100005;
int p[MXN], r[MXN];

void init(int n)
{
    for(int i = 0; i <= n; ++i)
    {
        p[i] = i;
        r[i] = 1;
    }
}

int Find(int x)
{
    return (x == p[x] ? x : p[x] = Find(p[x]));
}

bool Union(int x, int y)
{
    x = Find(x);
    y = Find(y);
    if(x == y)
    {
        return false;
    }
    if(r[x] == r[y])
    {
        p[y] = x;
        ++r[x];
    }
    else if(r[x] > r[y])
    {
        p[y] = x;
    }
    else
    {
        p[x] = y;
    }
    return true;
}

int main(){
    int n, m;
    cin >> n >> m;
    init(n);
    for(int i = 0, x, y, z; i != m; ++i)
    {
        cin >> x >> y >> z;
        if(Union(x, y))
        {
            --n;
        }
    }
    cout << n << '\n';
}
{% endcodeblock %}

* PG Friendships([ABC 131E](https://abc131.contest.atcoder.jp/tasks/abc131_e?lang=en))
題意：要你建構出一張有$N$個點的圖，其中有$K$組點對最短距離$=2$
解法：先考慮最大多組點對最短距離$=2$的數量，是中間一個點連到其他所有點，有$C(n-1, 2)$組，我們可以藉由將某兩個外部點連線來減少一組點對，這樣九可以過這題。

* PH Must Be Rectangular!([ABC 131F](https://abc131.contest.atcoder.jp/tasks/abc131_f?lang=en))
題意：一個二維平面上有$N$個點，如果有$(a,c)(b,c)(a,d)$三點，就增加$(a,d)$一點，問最後有幾點。
解法：任意兩點有相同$x$或$y$座標的點都視為同一群，每一群最後都會形成一個矩形，數量為x軸個數$\times$y軸個數。所以先分群，再算出答案即可。

* PI XOR Matching
題意：建構出長度為$2^{m+1}$的序列，每個數字為$0$到$2^{m}-1$，對於任意兩個相同的數字，其區間XOR值要$=k$。
解法：兩個相同數字XOR後$=0$，所以只要兩個數字中間包k和數對相同的數字就可以符合，剩下的問題是$k$，還有另一個性質是將$0$到$2^{m}-1$的數字XOR$=0$，所以把另一個$k$放在最外面就可以了。最後數列為$0, 2^{m}-1, 2^{m}-2, ..., 0, k, 0, 1, ..., 2^{m-1}$。

晚上上課就講一些基本的技巧，跟去年的課程差不多，要回去發現1樓有門禁，等了一下才有人幫忙開。