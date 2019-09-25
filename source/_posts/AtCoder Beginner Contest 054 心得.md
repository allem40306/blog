---
<!-- layout: layout -->
title: AtCoder Beginner Contest 054 心得
category: Atcoder
tags:
  - 基礎
  - 陣列
  - dfs
  - dp
abbrlink: 4b44
date: 2017-02-22 16:01:05
---
這是我的第一場atcoder比賽，打的不錯，除了D，其他都AC了!
結果:
A 基礎 AC
B 陣列 AC
C DFS AC
D DP 賽後AC
題解:
pA
如果是1的話就當成14，其他一樣
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define t(x) x==1?14:x

int main(){
	int a,b;
	cin>>a>>b;
	a=t(a);b=t(b);
	if(a>b)cout<<"Alice\n";
	else if(a<b)cout<<"Bob\n";
	else cout<<"Draw\n";
}
{% endcodeblock %}
pB
這題只是在判斷前面的陣列(A陣列)是否包含後面陣列(B陣列)，我的作法是先找出可能的範圍，在一個個判斷使否相符，複雜度O(N*M*M)。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define N 55
int n,m;
string s[N],r[N];

bool che(int i,int j){
	for(int a=0;a<m;a++){
		for(int b=0;b<m;b++){
			if(s[a+i][b+j]!=r[a][b])
				return 0;
		}
	}
	return 1;
}

bool solve(){
	for(int i=0;i<=n-m;i++)
		for(int j=0;j<=n-m;j++)
			if(che(i,j))
				return 1;
	return 0;		 
}

int main(){
	cin>>n>>m;
	for(int i=0;i<n;i++)
			cin>>s[i];
	for(int i=0;i<m;i++)
			cin>>r[i];
	if(solve())cout<<"Yes\n";
	else cout<<"No\n";
}
{% endcodeblock %}
pC

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define N 10
vector<int>v[N];
int n,m,x,y;
bool vis[N];

int solve(int a,int b){
	if(b==n)return 1;
	int ans=0;
	for(int i=0,j=v[a].size();i<j;i++){
		if(!vis[v[a][i]]){
			vis[v[a][i]]=1;
			ans+=solve(v[a][i],b+1);
			vis[v[a][i]]=0;
		}
	}
	return ans;
}

int main(){
	memset(vis,0,sizeof(0));
	cin>>n>>m;
	for(int i=0;i<m;i++){
		cin>>x>>y;
		v[x].push_back(y);
		v[y].push_back(x);
	}
	vis[1]=1;
	cout<<solve(1,1)<<endl;
}
{% endcodeblock %}
pD
一看知道是一題背包DP，但當下我無法立刻寫出來，賽後我參考解答，一開始發現三維陣列的，但後來查到二維陣列版本如下，每個dp[i][j]代表a有i克,b有j克下最小的花費，最後再搜一次所有(i,j)為K(ma,mb)的dp值，最小的為答案，找不到解要特判掉，dp花費O(N*M*M)的時間，搜尋花費O(M*M)的時間，總共花費O(N*M*M)的時間。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define N 40
#define M 405
int n,ma,mb,a[N],b[N],c[N],dp[M][M],ans=10000000,ans2;

int main(){
	cin>>n>>ma>>mb;
	for(int i=0;i<n;i++)
		cin>>a[i]>>b[i]>>c[i];
	for(int i=0;i<M;i++){
		for(int j=0;j<M;j++){
			dp[i][j]=ans;
		}
	}
	dp[0][0]=0;
	for(int i=0;i<N;i++){
		for(int j=M;j-a[i]>=0;j--){
			for(int k=M;k-b[i]>=0;k--){
				dp[j][k]=min(dp[j][k],dp[j-a[i]][k-b[i]]+c[i]);
			}
		}
	}
	ans2=ans;
	for(int i=1;i<=400;i++){
		for(int j=1;j<=400;j++){
			if(i*mb==j*ma)
				ans=min(ans,dp[i][j]);
		}
	}
	if(ans==ans2)cout<<"-1\n";
	else cout<<ans<<endl;
}
{% endcodeblock %}