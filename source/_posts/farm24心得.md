---
<!-- layout: layout -->
title: Codeforces Farm 競賽日記 24 心得
category: Codeforces
tags:
  - Codeforces
  - Twicpc
  - 陣列
  - math
abbrlink: '8897'
date: 2017-02-18 15:48:12
---
2/17參加cf競賽日記的比賽，以下是我的感想
結果:
A 陣列 AC
B 數學 賽後AC
C QQ
D QQ
E QQ
題解:
pA:水題一題，只要sort一遍，然後把奇數個和偶數個相減就AC了
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define N 100

int main(){
	long long n,a[N],ans=0;
	cin>>n;
	for(int i=0;i<2*n;i++)cin>>a[i];
	sort(a,a+2*n);
	for(int i=0;i<n;i++)
		ans+=a[2*i+1]-a[2*i];
	cout<<ans<<endl;
}
{% endcodeblock %}
pB:我原本沒想到，是學弟告訴我的，對每個數字i，先求出i個倍數個數，在C(個數,3)，在減i所有倍數的答案就AC了，至於陣列大小，A和B最大差為10^6，而(3i-i)=2i<|B-A|，所以陣列大小只要5*10^5就好了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
#define N 1000000
long long a,b,c,d,x,i,j,k,m,ans[N];

int main(){
	cin>>a>>b;
	for(i=1;;i++){
		c=(a/i)+1*(a%i>0);
		d=(b/i);
		x=d-c+1;
		if(x<3)break;
		ans[i]=x*(x-1)*(x-2)/6;
		}
	for(k=i;i;i--){
		for(j=k;j>i;j--){
			if(j%i==0)
				ans[i]-=ans[j];
		}
	}
	for(i=1;i<=k;i++){
		if(ans[i]>0)
			cout<<i<<' '<<ans[i]<<endl;
	}
}
{% endcodeblock %}