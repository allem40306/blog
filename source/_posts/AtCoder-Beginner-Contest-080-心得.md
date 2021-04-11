---
<!-- layout: layout -->
title: AtCoder Beginner Contest 080 心得
category: AtCoder
tags:
  - AtCoder
  - Enumerate 枚舉
  - 狀態壓縮
  - 離散化
abbrlink: 281d
date: 2017-12-11 16:09:24
---
這場比賽打得平平，卡在pC太久了，直到賽後才發現是ans變數要設小一點才AC。
<!-- more -->
結果:
A 基礎 AC
B 基礎 AC
C 枚舉+狀態壓縮 賽後AC
D 離散化 賽後AC

pA
比較哪個比較大
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int a,b,k;
    cin>>a>>b>>k;
    cout<<min(a*b,k)<<'\n';
}

{% endcodeblock %}

pB
照定義求出f(x)再看看是不是x的因數
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int f(int n){
    int ans=0;
    while(n){
        ans+=n%10;
        n/=10;
    }
    return ans;
}
 
int main(){
    int n,m;
    cin>>n;
    if(n%f(n)==0){
        cout<<"Yes\n";
    }else{
        cout<<"No\n";
    }
}
{% endcodeblock %}

pC
枚舉每種可能，算出對大的利益。這裡我用狀態壓縮，有一種寫法是用函數DFS每一時段開不開店。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N=105;
const int M=15;
long long int n,f[N][M],p[N][M],x,ans=-1000000000,c[N];
 
int main(){
    bool b=0;
    cin>>n;
    for(int i=0;i<n;i++){
        for(int j=0;j<10;j++){
            cin>>f[i][j];
        }
    }
    for(int i=0;i<n;i++){
        for(int j=0;j<11;j++){
            cin>>p[i][j];
        }
    }
    for(int i=1;i<(1<<10);i++){
        memset(c,0,sizeof(c));
        x=0;
        for(int j=0;j<=9;j++){
            if((1<<j)&i){
                for(int k=0;k<n;k++){
                    c[k]+=f[k][j];
                }
            }
        }
        for(int j=0;j<n;j++){
//            cout<<j<<' '<<c[j]<<'\n';
            x+=p[j][c[j]];
        }
//        cout<<i<<' '<<x<<'\n';
        ans=max(ans,x);
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}

pD
首先，對每一個頻道分開看，看該頻道所佔有的時間，之後再看哪個時間的所需用頻道數最多，即為答案。
13,14行:因為一開始錄之前0.5就要固定頻道，所以我們把時間軸拉長2倍，將開始時間-1來處理。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N=100001;
int n,c,ss[N],tt[N],cc[N],pre[2*N],a[2*N];
int main(){
    cin>>n>>c;
    for(int i=0;i<n;i++){
        cin>>ss[i]>>tt[i]>>cc[i];
    }
    memset(a,0,sizeof(a));
    for(int i=1;i<=c;i++){
        memset(pre,0,sizeof(pre));
        for(int j=0;j<n;j++){
            if(cc[j]!=i)continue;
            pre[ss[j]*2-1]++;
            pre[tt[j]*2]--;
        }
        for(int j=1;j<=2*N-2;j++){
            pre[j]+=pre[j-1];
            if(pre[j]>0)a[j]++;
        }
    }
    int ans=0;
    for(int i=1;i<=2*N-2;i++)ans=max(ans,a[i]);
    cout<<ans<<'\n';
}
{% endcodeblock %}