---
title: POJ3692 Kindergarten
category: POJ
tags:
  - POJ
  - bipartite graph
abbrlink: a062
date: 2019-02-12 15:41:28
---
http://poj.org/problem?id=3692
題意：所有的男生認識彼此，所有的女生也認識彼此，有些男女互相認識，求最大群體使得當中所有人都認識彼此。

題解：二分圖上的最大團，先把圖轉換成補圖，找出最大匹配後，答案即為|V(男女生總人數)|-|最大匹配|。

{% codeblock lang:cpp %}
#include <iostream>
#include <cstring>
#include <bitset>
using namespace std;
const int N=205;
int g, b;
int adj[N][N];
int Left[N];
bitset<N> used;

void init(){
    for(int i = 1; i <= g; i++){
        for(int j = 1; j <= b; j++){
            adj[i][j] = 1;
        }
    }
}

bool dfs(int s){
    for(int i = 1; i <= b; i++){
        if(!adj[s][i] || used[i])continue;
        used[i] = true;
        if(Left[i] == -1 || dfs(Left[i])){
            Left[i] = s;
            return true;
        }
    }
    return false;
}

int sol(){
    int ret = 0;
    memset(Left, -1, sizeof(Left));
    for(int i = 1; i <= g; i++){
        used.reset();
        if(dfs(i))ret++;
    }
    return ret;
}

int main(){
    int m, ti = 0;
    while(cin >> g >> b >> m, g || b || m){
        init();
        for(int i = 0, x, y; i < m; i++){
            cin >> x >> y;
            adj[x][y] = 0;
        }
        cout << "Case " << ++ti << ": " << g + b - sol() << "\n";
    }
}
{% endcodeblock %}