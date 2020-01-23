---
title: UVa 1175 Ladies' Choice
category: UVa
tags:
  - UVa
  - stable matching Problem
abbrlink: f13
date: 2019-10-14 23:02:25
---

題意：有$N$個男生和女生，給定他們對異性喜歡的順序，要你找出一種配對"盡量"使得每一隊都找到自己最想要的伴侶。
<!-- more -->
解法：這是經典的穩定婚姻問題(Stable Matching Problem)，用的是用求婚拒绝算法（Propose-and-reject algorithm），一開始先讓所有男生跟他自己最喜愛的女生配對，當有兩個男生同時要跟一名女生配對，女生會選擇自己喜愛的男生配對，讓另一名男生去找下一個順序配對。
最後要輸出的是第$i$位男生所配對到的女生。

{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N=1005;
int t,n,b[N][N],bi[N],g[N][N],bg[N],gb[N];

void sol(){
    deque<int>dq;
    memset(gb,0,sizeof(gb));
    memset(bi,0,sizeof(bi));
    for(int i=1;i<=n;i++)dq.push_back(i);
    while(!dq.empty()){
        int x=dq.front(); dq.pop_front();
        int y=b[x][++bi[x]];
        if(!gb[y]){
            gb[y]=x;
            bg[x]=y;
        }else if(g[y][x]<g[y][gb[y]]){
            dq.push_back(gb[y]);
            gb[y]=x;
            bg[x]=y;
        }else{
            dq.push_back(x);
        }
    }
    for(int i=1;i<=n;i++){
        cout<<bg[i]<<'\n';
    }
}

int main(){
    int x;
    cin>>t;
    for(int i=0;i<t;i++){
        cin>>n;
        for(int i=1;i<=n;i++){
            for(int j=1;j<=n;j++){
                cin>>b[i][j];
            }
        }
        for(int i=1;i<=n;i++){
            for(int j=1;j<=n;j++){
                cin>>x;
                g[i][x]=j;
            }
        }
        if(i)cout<<'\n';
        sol();
    }
}
{% endcodeblock %}