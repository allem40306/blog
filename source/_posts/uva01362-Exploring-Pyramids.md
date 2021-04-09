---
title: uva01362 Exploring Pyramids
abbrlink: 7f79
date: 2020-07-28 23:22:01
category: UVa
tags:
- UVa
- DP
- 區間 DP
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=4108)
* 題意：給定一個由 `AB` 組成的字串，問有多少種多元樹遍歷的過程(一個節點經過一次)，可用該字串表示。
<!-- more -->
* 題解：區間 DP。對於一個區間 $[L,R]$，枚舉位置 $[L+2, R]$，如果 $s[L] == s[R]$，代表 $L$ 和 $i$ 有可能是同一個點，分別遞迴 $[L+1, i-1]$ 和 $[i+1, R]$ 去尋找答案。
```cpp=
#include <bits/stdc++.h>
using namespace std;
string s;
typedef long long LL;
const int N=305;
const LL mod=1000000000;
LL a[N][N];

LL dp(int L, int R) {
	if (L == R)return 1;
	if(s[L]!=s[R])return 0;
	LL& ans = a[L][R];
	if (ans >= 0)return ans;
	ans = 0;
	for (int i = L + 2; i <= R; i++) {
		if(s[L]==s[i])ans=(ans+(LL)dp(L+1,i-1)*dp(i,R))%mod;
	}
	return ans;
}

int main() {
	while (cin >> s) {
		memset(a, -1, sizeof(a));
		cout << dp(0, s.size() - 1)<<'\n';
	}
}
```