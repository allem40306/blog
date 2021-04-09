---
title: uva11997 K Smallest Sums
abbrlink: efbd
date: 2020-07-24 16:05:42
category: UVa
tags:
- UVa
- STL
- Priority_queue
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3148)
* 題意：給定 $K$ 組 $K$ 個正整數，從 $K$ 組中各取一個數字有 $K^K$ 種組合，要求輸出前 $K$ 小的數字
<!-- more -->
* 題解：一組一組數字合併，第 $i$ 組數字(令其為 $B$)，與前面 $i-1$ 組序列中前 $k$ 小的組合(令其為 $A$)比較。在 $A$ 和 $B$ 都是由小到大排序好的狀況下，我們在 `priority_queue` 放入 $A_1+B_1, A_2+B_1, A_3+B_1, ..., A_k+B_1$，第一小的肯定是 $A_1+B_1$，第二小的有可能是 $A_1+B_2$ 或 $A_2+B_1$，所以我們在 `priority_queue` 取出後 $A_1+B_1$，放入 $A_1+B_2$ 和其他組合比較，依照這個規則，我們在取出 $A_i+B_i$ 後，就放入 $A_i+B_{i+1}$ 在 `priority_queue` 裡比較，就可以把前 $K$ 大的組合找出來。
```cpp=
#include <bits/stdc++.h>
using namespace std;
const int N=1000;

struct Data{
    int sum,i;
    bool operator<(const Data &rhs)const{
        return sum>rhs.sum;
    }
};

int main(){
    int n; // 這裡的 n 就是題目說的 K
    int a[N],b[N];
    while(cin>>n){
        for(int i=0;i<n;i++){
            cin>>a[i];
        }
        sort(a,a+n);
        for(int ni=1;ni<n;ni++){
            for(int i=0;i<n;i++){
                cin>>b[i];
            }
            sort(b,b+n);
            priority_queue<Data>pq;
            for(int i=0;i<n;i++){
                pq.push(Data{a[i]+b[0],0});
            }
            for(int i=0;i<n;i++){
                Data tmp=pq.top(); pq.pop();
                a[i]=tmp.sum;
                if(tmp.i+1<n){
                    pq.push(Data{tmp.sum-b[tmp.i]+b[tmp.i+1],tmp.i+1});
                }
            }
        }
        for(int i=0;i<n;i++){
            if(i)cout<<' ';
            cout<<a[i];
        }
        cout<<'\n';
    }
}
```