---
title: POJ1419 Graph Coloring
category: POJ
tags:
  - POJ
  - graph
abbrlink: ef6a
date: 2019-02-13 20:25:40
---
http://poj.org/problem?id=1419
題意：求最大點集合使得集合內的點兩兩皆不相鄰。

這題就是要求最大點獨立集，也就是求補圖最大團，而最大團藉由枚舉來求得。

{% codeblock lang:cpp %}
#include <iostream>
#include <vector>
#include <cstring>
using namespace std;
const int N = 105;
int n;
int adj[N][N];
int tmp, ans;
int tmp_res[N], ans_res[N];

void dfs(int s){
    if(s > n){// all vertexes are searched
        memcpy(ans_res, tmp_res,sizeof(ans_res));
        ans = tmp;
        return;
    }
    bool ok = true;
    for(int i = 0; i < tmp; i++){
        if(adj[s][tmp_res[i]] == 0){
            ok = false;
            break;
        }
    }
    if(ok){// add vertex s
        tmp_res[tmp++] = s;
        dfs(s + 1);
        tmp--;
    }
    if(tmp + (n - s) > ans){// not to add vertex s
        dfs(s + 1);
    }
}

int main(){
    int t, m;
    cin >> t;
    while(t--){
        cin >> n >> m;
        memset(adj, -1, sizeof(adj));
        for(int i = 0, x, y; i < m; i++){
            cin >> x >> y;
            adj[x][y] = adj[y][x] = 0;
        }
        tmp = ans = 0;
        dfs(1);
        cout << ans << '\n';
        for(int i = 0 ;i < ans; i++){
            if(i)cout<<' ';
            cout << ans_res[i];
        }
        cout << '\n';
    }
}
{% endcodeblock %}