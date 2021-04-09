---
title: uva11367 Full Tank?
abbrlink: 8a61
date: 2020-07-23 23:17:55
category: UVa
tags:
  - UVa
  - Graph
  - Shortest Path
  - Dijkstra
  - 程式競賽選修課
  - 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2352)
* 題意：給定 $N$ 個城市和 $M$ 條道路，每個點給定加油的費用，每條邊給定經郭需花費得油量，問從城市 $s$ 到城市 $e$，用一台容量只有 $c$ 單位油量的車，最少需要花多少成本
<!-- more -->
* 題解：這題最小成本，加上油量的條件，因為沒有負邊，可以用 dijkstra 解出，狀態除了`目前所在的城市`(s)，`花費成本`(v)外，還需要紀錄 `當前油量`(r)。轉移由兩種辦法，第一個是去別個城市，第二個是加一單位的油量。這樣所產生的新狀態不會太多，否則很容易會吃 TLE。

```cpp=
#include <bits/stdc++.h>
using namespace std;
#define MP make_pair
typedef pair<int,int> PII;
const int N=1005;
int cost[N];
vector<PII>v[N];
int d[N][N];
bitset<N>vis[N];

struct Data{
    int s,r,v;
    bool operator<(const Data&rhs)const{
        return v>rhs.v;
    }
};

void add_edge(int from,int to,int w){
    v[from].push_back(MP(to,w));
    v[to].push_back(MP(from,w));
}

int sol(int c,int s,int e){
    memset(d,0x3f,sizeof(d));
    for(int i=0;i<N;i++)vis[i].reset();
    d[s][0]=0;
    priority_queue<Data>pq;
    pq.push(Data{s,0,d[s][0]});
    while(!pq.empty()){
        Data k=pq.top(); pq.pop();
        int ss=k.s,rr=k.r;
        if(ss==e)return d[ss][rr];
        if(vis[ss][rr])continue;
        vis[ss][rr]=1;
        // cout<<ss<<' '<<rr<<' '<<d[ss][rr]<<'\n';
        for(auto it:v[ss]){
            int u=it.first,w=it.second;
            if(w>rr)continue;
            if(d[u][rr-w]>d[ss][rr]){
                d[u][rr-w]=d[ss][rr];
                // cout<<u<<' '<<rr-w<<d[u][rr-w]<<'\n';
                pq.push(Data{u,rr-w,d[u][rr-w]});
            }
        }
        if(rr<c&&d[ss][rr+1]>d[ss][rr]+cost[ss]){
            d[ss][rr+1]=d[ss][rr]+cost[ss];
            pq.push(Data{ss,rr+1,d[ss][rr+1]});
        }
    }
    return -1;
}

int main(){
    int n,m,q;
    while(cin>>n>>m){
        for(int i=0;i<n;i++){
            cin>>cost[i];
        }
        for(int i=0;i<N;i++)v[i].clear();
        for(int i=0,f,t,w;i<m;i++){
            cin>>f>>t>>w;
            add_edge(f,t,w);
        }
        cin>>q;
        for(int i=0,c,s,e;i<q;i++){
            cin>>c>>s>>e;
            int ans=sol(c,s,e);
            if(ans==-1)cout<<"impossible\n";
            else cout<<ans<<'\n';
        }
    }
}
```