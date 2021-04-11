---
title: UVa00750 UvaLive5358 8 Queens Chess Problem
abbrlink: 614c
date: 2020-08-15 16:36:27
category: UVa
tags:
- UVa
- UVaLive
- 遞迴
- 剪枝
- ICPC 亞洲訓練聯盟暑訓 2020
---
[題目連結 UVa](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=691)
[題目連結 UvaLive](https://icpcarchive.ecs.baylor.edu/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3359)
* 題意：給定八皇后問題其中一顆棋子，求所有可能的八皇后問題解。
<!-- more -->
* 題解：經典八皇后問題，遞迴到已經放過棋子的那一層就直接跳過。
```cpp=
#include <iostream>
#include <cstring>
using namespace std;
int vis[20][20],cur[20],x,y,c;//0 x 1 \ 2 / c:caculate

void dfs(int n){
    if(n==9){
        if(c/10==0)cout<<' ';
        cout<<c++<<"     ";
        for(int i=1;i<=8;i++){
            cout<<' '<<cur[i];
        }
        cout<<'\n';
        return;
    }if(n==y){
        dfs(n+1);
    }else{
        for(int i=1;i<=8;i++){
            if(!vis[0][i]&&!vis[1][i-n+8]&&!vis[2][i+n]){
                cur[n]=i;
                vis[0][i]=vis[1][i-n+8]=vis[2][i+n]=1;
                dfs(n+1);
                vis[0][i]=vis[1][i-n+8]=vis[2][i+n]=0;
            }
        }
    }
    return;
}

int main(){
    int n;
    for(cin>>n;n;n--){
        cin>>x>>y;
        memset(vis,0,sizeof(vis));
        c=1;
        vis[0][x]=vis[1][x-y+8]=vis[2][x+y]=1;
        cur[y]=x;
        cout<<"SOLN       COLUMN\n #      1 2 3 4 5 6 7 8\n\n";
        dfs(1);
        if(n>1)cout<<'\n';
    }
}
```