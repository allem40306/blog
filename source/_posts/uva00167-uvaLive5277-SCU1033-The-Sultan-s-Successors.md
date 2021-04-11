---
title: UVa00167 UvaLive5277 SCU1033 The Sultan's Successors
abbrlink: '7020'
date: 2020-08-15 16:27:41
category: UVa
tags:
- UVa
- UVaLive
- SCU
- 遞迴
- 剪枝
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 UVa](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=103)
[題目連結 UvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3228)
[題目連結 SCU](http://acm.scu.edu.cn/soj/problem.action?id=1033)
* 題意：給定 $8\times 8$ 棋盤，每一格上面都有數字，要放 8 隻皇后，在彼此不衝突的情況下，每隻皇后所在位置的數字和最大為多少。
<!-- more -->
* 題解：八皇后經典題，增加要算總和的部分。
* 備註：hdu 1642 也是同一題，但我試都是 TLE，因此沒放上來。
```cpp=
#include <iostream>
#include <iomanip>
using namespace std;
#define N 100
int vis[N][N], c[N], n;
int a[N][N], maxx;

void search(int cur){
	if (cur == n){
		int ans = 0;
		for (int i = 0; i < n; i++)
			ans+=a[i][c[i]];
		maxx = (maxx>ans ? maxx : ans);
		return;
	}
	else for (int i = 0; i < n; i++) {
		if (!vis[0][i] && !vis[1][cur + i] && !vis[2][cur - i + n]){
			c[cur] = i;
			vis[0][i] = vis[1][cur + i] = vis[2][cur - i + n] = 1;
			search(cur + 1);
			vis[0][i] = vis[1][cur + i] = vis[2][cur - i + n] = 0;
		}
	}
	return;
}

int main(){
	n = 8;
	for (int i = 0; i < N; i++){
		c[i] = 0;
		for (int j = 0; j < N; j++)
			vis[i][j] = 0;
	}
	int t;
	while (cin >> t){	
		maxx = 0;
		for (int i = 0; i < t; i++){
			for (int j = 0; j < n; j++)
				for (int k = 0; k < n; k++)
					cin >> a[j][k];
			search(0);
			printf("%5.d\n", maxx);
			maxx = 0;
		}		
	}
}
```