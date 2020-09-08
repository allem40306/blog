---
title: uva00639 uvaLive5325 POJ1315 OpenJ_Bailian1315 Don't Get Rooked
abbrlink: 483a
date: 2020-08-15 16:33:09
category: UVa
tags:
- UVa
- UVaLive
- POJ
- OpenJ_Bailian
- 遞迴
- 剪枝
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 uva](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=580)
[題目連結 uvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3326)
[題目連結 POJ](http://poj.org/problem?id=1315)
* 題意：給定 $4\times 4$ 的棋盤，上面有一些格子有障礙物，求最多可以放多少顆西洋棋裡的城堡彼此不衝突，衝突定義為兩顆城堡在同一直行或橫列，且中間沒有阻隔。
[題目連結]()
<!-- more -->
* 題解：遞迴搜索，每放一顆棋，先在上下左右 4 方位檢查有沒有會衝突的棋子。
```cpp=
#include <iostream>
#include <string>
using namespace std;
#define N 100
int vis[N][N], n, mmax;
int d[4][2] = { { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } };
string s[N];

bool isok(int i, int j){
	for (int a = 0; a < 4; a++){
		int dx = i+d[a][0], dy = j+d[a][1];
		while (dy >= 0 && dy < n&&dx >= 0 && dx < n){
			if (s[dx][dy] == 'X')break;
			if (vis[dx][dy])return false;
			dx += d[a][0], dy += d[a][1];
		}
	}
	return true;
}

void search(int cur){
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++){
			if (!vis[i][j] && s[i][j] != 'X'&&isok(i, j)){
				vis[i][j] = 1;
				search(cur + 1);
				vis[i][j] = 0;
			}
		}
	}
	if (cur>mmax)mmax = cur;
	return;
}

int main(){
	while (cin >> n, n){
		mmax = 0;
		for (int i = 0; i < n; i++)cin >> s[i];
		for (int i = 0; i < N; i++)
			for (int j = 0; j < N; j++)
				vis[i][j] = 0;
 		search(0);
		printf("%d\n", mmax);
	}
}
```