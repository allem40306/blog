---
<!-- layout: layout -->
title: uva00562 Dividing coins (Zerojudge d390)
category: UVa
tags:
  - UVa
  - Zerojudge
  - dp
  - 背包 dp
abbrlink: 3ef0
date: 2017-12-31 22:30:47
---
連結1:http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=24&page=show_problem&problem=503
連結2:https://zerojudge.tw/ShowProblem?problemid=d390
這題題意是要問所給出的m個幣值，分兩推的最小差距。
<!-- more -->
做法:先背包dp，再從可能的方法找出答案
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N=50005;

int main(){
    int n,m,x,sum,ans;
    bool dp[N];
    cin>>n;
    while(n--){
        memset(dp,0,sizeof(dp));
        sum=0;
        cin>>m;
        while(m--){
            cin>>x;
            sum+=x;
            for(int j=sum;j-x>=0;j--){
                if(!(j-x)||dp[j-x]){
                    dp[j]=1;
                }
            }
        }
        ans=sum;
        for(int i=1;i<=sum/2;i++){
            if(dp[i]){
                ans=sum-2*i;
            }
        }
        cout<<ans<<'\n';
    }
}
{% endcodeblock %}