---
title: uva11478 Halum (差分約束)
category: Uva
tags:
  - Uva
  - graph
abbrlink: 57c1
date: 2019-02-14 20:34:54
---
https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&category=550&problem=2473&mosmsg=Submission+received+with+ID+14137690
題意：給一張圖，邊有權重，有個操作X(s,v)，點s為起點的邊+v，點s為終點的邊-v，可以有無限次操作，在最後所有邊權重大於0的情況，最小的權重最大可以為多少。
<!-- more -->
解答：對於一條s到t的邊，他的權重增加Xsum(s)，減少了Xsum(t)(Xsum(s)為s操作的總值)，那麼我們可以二分搜答案x，Xsum(s)-Xsum(t)+w(s,t)>=x，Xsum(s)-Xsum(t)<=w(s,t)-x，這樣就可以轉化為差分約束了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N = 505;
struct Edge{
    int t, w;
};
int v, e;
int d[N], cnt[N];
bitset<N> inq;
queue<int>Q;
vector<Edge>G[N];

void addEdge(int from, int to, int w){
    G[from].push_back({to,w});
}

bool hasnegativeCycle(int x){
    while(!Q.empty())Q.pop();
    for(int i = 1; i <= v;i++){
        inq[i] = true;
        cnt[i] = d[i] = 0;
        Q.push(i);
    }
    while(!Q.empty()){
        int s = Q.front(); Q.pop();
        inq[s] = false;
        for(Edge it: G[s]){
            if(d[it.t] > d[s] + it.w - x){
                d[it.t] = d[s] + it.w - x;
                if(inq[it.t])continue;
                Q.push(it.t);
                inq[it.t] = true;
                if(++cnt[it.t] > v)return true;
            }
        }
    }
    return false;
}

void sol(int L, int R){
    if(hasnegativeCycle(1)){
        cout << "No Solution\n";
    }else if(!hasnegativeCycle(R + 1)){
        cout << "Infinite\n";
    }else {
        while(L != R){
            int M= (L + R + 1) >> 1;
            if(hasnegativeCycle(M))R = M - 1;
            else L = M;
        }
        cout << L << '\n';
    }
}

int main(){
    int mxw;
    while(cin >> v >> e){
        for(int i = 0; i <= v; i++)G[i].clear();
        mxw = 0;
        for(int i = 0, f, t, w; i < e; i++){
            cin >> f >> t >> w;
            addEdge(f, t, w);
            mxw = max(mxw, w);
        }
        sol(1, mxw);
    }
}
{% endcodeblock %}