---
title: UVa11383 Golden Tiger Claw
abbrlink: '39e0'
date: 2020-07-30 11:14:29
category: UVa
tags:
- UVa
- Graph
- Kuhn-Munkres Algorithm
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2378)
* 題意：給定數字 $N$ 和 $N\times N$ 的數字盤 $w$，要在每一 row, column 求出 $row[i], col[j],1\leq i,j \leq n$，$row[i]+col[j]>=w[i][j]$，並最小化 $\Sigma_{i=1}^n(row[i])+\Sigma_{j=1}^n(col[j])$。
<!-- more -->
* 題解：這是經典的二分圖最大匹配，用 KM 演算法就可以解出，$row[i], col[j]$ 各為一群，$row[i]$ 連到 $col[j]$ 的權重為 $w[i][j]$。
```cpp=
#include <bits/stdc++.h>
using namespace std;
const int N = 505;
int n;
int Left[N];
int w[N][N], Lx[N], Ly[N];
bitset<N> vx, vy;

bool match(int i) {
	vx[i] = true;
	for (int j = 1; j <= n; j++) {
		if (Lx[i] + Ly[j] - w[i][j] == 0 && !vy[j]) {
			vy[j] = true;
			if (!Left[j] || match(Left[j])) {
				Left[j] = i;
				return true;
			}
		}
	}
	return false;
}

void update() {
	int a = 200;
	for (int i = 1; i <= n; i++) {
		if (vx[i])for (int j = 1; j <= n; j++) {
				if (!vy[j])a = min(a, Lx[i] + Ly[j] - w[i][j]);
			}
	}
	for (int i = 1; i <= n; i++) {
		if (vx[i])Lx[i] -= a;
		if (vy[i])Ly[i] += a;
	}
}

void KM() {
	for (int i = 1; i <= n; i++) {
		Left[i] = Lx[i] = Ly[i] = 0;
		for (int j = 1; j <= n; j++) {
			Lx[i] = max(Lx[i], w[i][j]);
		}
	}
	for (int i = 1; i <= n; i++) {
		while (true) {
			vx.reset(); vy.reset();
			if (match(i))break;
			update();
		}
	}
}

int main(){
    while(cin >> n){
        for(int i = 1; i <= n; i++){
            for(int j = 1; j <= n; j++){
                cin >> w[i][j];
            }
        }
        KM();
        int ans = 0;
        for(int i = 1; i <= n ; i++){
            ans += Lx[i];
            if(i != 1)cout << ' ';
            cout << Lx[i]; 
        }
		cout << '\n';
        for(int i = 1; i <= n ; i++){
            ans += Ly[i];
            if(i != 1)cout << ' ';
            cout << Ly[i]; 
        }
		cout << '\n';
        cout << ans << '\n';
    }
}
```