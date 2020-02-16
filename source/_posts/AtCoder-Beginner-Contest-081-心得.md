---
title: AtCoder Beginner Contest 081 心得
category: AtCoder
tags:
  - AtCoder
  - 枚舉
  - stl
  - map
  - vector
  - 模擬
abbrlink: e4dc
date: 2017-12-11 21:43:28
---
這次我第一次在AtCoder破台，開心!!!前三題很快就解出來了，第四題想了很久才解出來(快結束時)。
<!-- more -->
結果:
A 基礎 AC
B 基礎 AC
C STL(map+vector) AC
D 模擬 AC

pA
問你這字串有幾個1，這題用字串或是整數都可以實作。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int n,ans=0;
    cin>>n;
    while(n){
        ans+=n%10;
        n/=10;
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}

pB
求這幾個數字最大可以2的n次方整除，直接一個一個找答案然後取最大的就好了。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int n,x,ans=100000,t;
    cin>>n;
    while(n--){
        t=0;
        cin>>x;
        while(x%2==0){
            t++;
            x/=2;
        }
        ans=min(ans,t);
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}

pC
把每一種數字都紀錄幾個，如果種數超過k就把前(k-種數)種數字的和加起來。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int n,k,x;
    map<int,int>ma;
    cin>>n>>k;
    for(int i=0;i<n;i++){
        cin>>x;
        if(ma.find(x)!=ma.end()){
            ma[x]+=1;
        }else{
            ma[x]=1;
        }
    }
    vector<int>v;
    for(auto it:ma){
        v.push_back(it.second);
    }
    sort(v.begin(),v.end());
    int ans=0;
    if(v.size()<=k){
        cout<<"0\n";
        return 0;
    }
    for(int i=0;i<v.size()-k;i++){
        ans+=v[i];
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}

pD
如果這題是全正或全負就可以直接做(全正:由左到右；全負:由右至左)，那如果是有正有負，那麼比較絕對值，看哪一個比較大，就把每一個數都加上它，就變成全正或全負的。所以保證2N個操作內可以完成(實際2N-1)。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
const int N=55;
int n,a[N],h=0;//head
int main(){
    cin>>n;
    for(int i=0;i<n;i++){
        cin>>a[i];
        if(abs(a[i])>abs(a[h]))h=i;
    }
    cout<<2*n-1<<'\n';
    for(int i=0;i<n;i++){
        cout<<h+1<<' '<<i+1<<'\n';
    }
    if(a[h]>0){
        for(int i=0;i<n-1;i++){
            cout<<i+1<<' '<<i+2<<'\n';
        }
    }else{
        for(int i=n;i>1;i--){
            cout<<i<<' '<<i-1<<'\n';
        }
    }
}
{% endcodeblock %}