---
title: uva00301 uvaLive5516 POJ1040 HDU1456 SCU1031 OpenJ_Bailian1040 Transportation
abbrlink: 9e4e
date: 2020-08-15 16:31:41
category: UVa
tags:
- UVa
- UVaLive
- POJ
- HDU
- SCU
- OpenJ_Bailian
- 遞迴
- 剪枝
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=237)
[題目連結 POJ](http://poj.org/problem?id=1040)
[題目連結 HDU](http://acm.hdu.edu.cn/showproblem.php?pid=1456)
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3517)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=1031)
[題目連結 OpenJ_Bailian1040](http://bailian.openjudge.cn/practice/1040?lang=en_US)
* 題意：有一列火車從 $A$($0$ 號車站) 開到 $B$($m$ 號車站)，路上經過車站依序編號為 $0$ 到 $m$，現在有 $t$ 筆訂單，每筆訂單有人數，起點和終點，如果接受這筆訂單，就可以獲得人數 $\times$ 經過站數(終點-起點)，火車最多可以載 $n$ 位客人，求最高獲益。
<!-- more -->
* 題解：遞迴爆搜，利用前綴和和差分檢查如果加入當前訂單，車上的容量是否足夠。另外需要剪枝，當前的已接受的訂單 + 還沒確定是否要接受的訂單，所有獲益無法成為最佳解即停止搜索。
```cpp=
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <vector>

using namespace std;
typedef long long LL;
struct Data
{
    int s, t, n, cost;
    bool operator<(const Data &rhs) const { return cost < rhs.cost; }
};
int n, b, t;
int ans;
vector<int> costSum(25), sum(10);
vector<Data> v;

void doit(int d, int dir)
{
    sum[v[d].s] += dir * v[d].n;
    sum[v[d].t] -= dir * v[d].n;
}

bool ok()
{
    int total = 0;
    for (int i = 0; i <= b; ++i)
    {
        total += sum[i];
        if (total > n)
        {
            return false;
        }
    }
    return true;
}

void dfs(int d, int cur)
{
    // cout << d << ' ' << cur << '\n';
    ans = max(ans, cur);
    if (d == t)
    {
        return;
    }
    if(cur + costSum[d] <= ans)
    {
        return;
    }
    doit(d, 1);
    if (ok())
    {
        dfs(d + 1, cur + (v[d].t - v[d].s) * v[d].n);
    }
    doit(d, -1);
    dfs(d + 1, cur);
    return;
}

int main()
{
    while (cin >> n >> b >> t, n || b || t)
    {
        v.resize(t);
        fill(sum.begin(), sum.end(), 0);
        fill(costSum.begin(), costSum.end(), 0);
        for (int i = 0; i < t; ++i)
        {
            cin >> v[i].s >> v[i].t >> v[i].n;
            v[i].cost = v[i].n * (v[i].t - v[i].s);
        }
        sort(v.begin(), v.end());
        for (int i = t - 1; i >= 0; --i)
        {
            costSum[i] = costSum[i + 1] + v[i].cost;
        }
        ans = 0;
        dfs(0, 0);
        cout << ans << '\n';
    }
}
```