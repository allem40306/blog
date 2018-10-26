<!-- layout: layout -->
title: AtCoder Beginner Contest 107 心得
date: 2018-10-24 22:12:00
category: Atcoder
tags:
- Atcoder
---
這場很久以前打的，只是都沒時間整理，PD是賽後AC的，這題值得好好思考。

PA水題，有N節車廂，從前看是M節，從後看是第X節，X+M=N+1，故X=N-M+1。
{% codeblock lang:cpp %}
#include <iostream>
using namespace std;
 
int main(){
	int n,m;
	while(cin>>n>>m){
		cout<<n-m+1<<'\n';
	}
}
{% endcodeblock %}

PB，把只有`.`的行列刪掉，用陣列紀錄是不是只有`.`，最後輸出跳過這些行列就好了。
{% codeblock lang:cpp %}
#include <iostream>
using namespace std;
const int N = 105;
 
int main() {
	int n, m, r[N] = {}, c[N] = {};
	string s[N];
	cin >> n >> m;
	for (int i = 0; i < n; i++) {
		cin >> s[i];
		for (int j = 0; j < m; j++) {
			if (s[i][j] == '#') {
				r[i]++;
				c[j]++;
			}
		}
	}
	for (int i = 0; i < n; i++) {
		if (!r[i])continue;
		for (int j = 0; j < m; j++) {
			if (!c[j])continue;
			cout << s[i][j];
		}
		cout << '\n';
	}
}
{% endcodeblock %}

PC枚舉範圍，要點的蠟燭要是連續才會有最小時間。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N = 100005;
 
int main() {
	int n, m;
	long long a[N], ans = 10000000000;
	cin >> n >> m;
	for (int i = 0; i < n; i++) {
		cin >> a[i];
	}
	for (int i = 0; i + m <= n; i++) {
		if (a[i] <= 0 && 0 <= a[i + m - 1]) {
			ans = min(ans, 2 * (a[i + m - 1] - a[i]) - max(-a[i], a[i + m - 1]));
		} else {
			ans = min(ans, max(abs(a[i + m - 1]), abs(a[i])));
		}
		// cout << i << ' ' << ans << '\n';
	}
	cout << ans << '\n';
}
{% endcodeblock %}
PD這題我還不太了解為什麼可以這樣轉，詳情可見這篇 https://blog.csdn.net/qq_31645627/article/details/82113914 ，之後我會再補解釋。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N = 100005;
typedef long long LL;
#define lowbit(x) (x&(-x))
LL n;
LL a[N], b[N], bit[4 * N];
 
void add(LL x, LL val) {
	x += n + 1;
	for (; x <= 2 * n + 1; x += lowbit(x)) {
		bit[x] += val;
	}
}
 
LL sum(LL x) {
	LL val = 0;
	x += n + 1;
	for (; x > 0; x -= lowbit(x)) {
		val += bit[x];
	}
	return val;
}
 
LL sol(LL x) {
	LL tmp = 0, ans = 0;
	for (int i = 1; i <= n; i++) {
		if (a[i] <= x) {
			tmp++;
		} else {
			tmp--;
		}
		ans += sum(tmp - 1);
		add(tmp, 1);
	}
	tmp = 0;
	for (int i = 1; i <= n; i++) {
		if (a[i] <= x) {
			tmp++;
		} else {
			tmp--;
		}
		add(tmp, -1);
	}
	return ans;
}
 
int main(int argc, char const *argv[]) {
	cin >> n;
	for (int i = 1; i <= n; i++) {
		cin >> a[i];
		b[i] = a[i];
	}
	memset(bit, 0, sizeof(bit));
	sort(b, b + n);
	LL nn = unique(b + 1, b + 1 + n) - b - 1;
	LL L = 1, R = nn, M, ans;
	LL tar = (n * (n + 1) / 2) / 2 + 1;
	add(0, 1);
	while (L <= R) {
		M = (L + R) >> 1;
		LL res = sol(b[M]);
		if (res >= tar) {
			ans = b[M];
			R = M - 1;
		} else {
			L = M + 1;
		}
	}
	cout << ans << '\n';
	return 0;
}
{% endcodeblock %}
