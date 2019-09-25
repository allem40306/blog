---
<!-- layout: layout -->
title: AtCoder Beginner Contest 082 心得
category: Atcoder
tags:
  - Atcoder
  - 基礎
  - algorithm
  - dp
abbrlink: f19c
date: 2017-12-17 19:52:03
---
這次的難度老實說比上次簡單，但最後一題一直有bug所以解不出來，賽後詢問才發現。
A 基礎 AC
B algorithm函式庫 AC
C 基礎 AC
D DP 賽後AC

pA
這題要把兩個數平均在四捨五入，直接把兩數相加再加1然後除以2就可以得到答案了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int a,b;
    cin>>a>>b;
    cout<<(a+b+1)/2<<'\n';
}
{% endcodeblock %}

pB
這題要把第一個字串由a到z排，第二個字串由z到a排，然後比較大小。
我的辦法是用sort排過，把第二個字串用reverse顛倒，在比大小就AC了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    string a,b;
    cin>>a>>b;
    sort(a.begin(),a.end());
    sort(b.begin(),b.end());
    reverse(b.begin(),b.end());
    if(a<b){
        cout<<"Yes\n";
    }else{
        cout<<"No\n";
    }
}
{% endcodeblock %}

pC
這題是要讓數字x在數列中剛好出現x次，如果不符合，就把一些數移除，問最少要移除多少次。
我的作法是先sort一遍，在一一記數，如果x出現小於x次，就移除全部的x，否則就把x個x保留，移除多餘的X。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int n,x;
    vector<int>v;
    cin>>n;
    for(int i=0;i<n;i++){
        cin>>x;
        v.push_back(x);
    }
    sort(v.begin(),v.end());
    int ans=0,tmp=v[0],c=1;
    for(int i=1;i<v.size();i++){
        if(v[i]==v[i-1])c++;
        else{
            if(c!=tmp){
                ans+=(c>tmp?c-tmp:c);
            }
            tmp=v[i];
            c=1;
        }
    }
    if(c!=tmp){
            ans+=(c>tmp?c-tmp:c);
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}

pD
有一個機器人接受兩種命令，T和F
T:轉向90度，順時或逆時皆可。
F:往目前方向前進一步
一開始的位置在(0,0)並且面對+x方向
給定命令串s及x,y
問你可不可以走到(x,y)
我的做法是分別對x/y方向做背包dp，看看能不能走到x/y的位置，但要注意一開始第一次一定是朝+x方向，不可加入dp中(我就是卡在這裡QQ)。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    string s;
    int x,y;
    cin>>s>>x>>y;
    vector<int>a,b;
    bool isx=1;
    int c=0;
    for(int i=0;i<s.size();i++){
        if(s[i]=='F'){
            c++;
        }else{
            if(isx){
                a.push_back(c);
            }else{
                b.push_back(c);
            }
            c=0;
            isx=(!isx);
        }
    }
    if(s[s.size()-1]=='F'){
        if(isx){
            a.push_back(c);
        }else{
            b.push_back(c);
        }
    }
    const int N=8005;
    bool dpa[N]={1},dpb[N]={1};
    int suma=0,sumb=0;
    for(int i=1;i<a.size();i++){
        suma+=a[i];
        for(int j=suma;j-a[i]>=0;j--){
            if(dpa[j-a[i]])dpa[j]=1;
        }
    }
    for(int i=0;i<b.size();i++){
        sumb+=b[i];
        for(int j=sumb;j-b[i]>=0;j--){
            if(dpb[j-b[i]])dpb[j]=1;
        }
    }
    x=abs(x-a[0]);
    y=abs(y);
    if((suma>=x&&sumb>=y)&&(((suma-x)%2==0&&dpa[(suma-x)/2]))&&(((sumb-y)%2==0&&dpb[(sumb-y)/2]))){
        cout<<"Yes\n";
    }else{
        cout<<"No\n";
    }
}
{% endcodeblock %}