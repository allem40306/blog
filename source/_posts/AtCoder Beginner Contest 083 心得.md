---
title: AtCoder Beginner Contest 083 心得
date: 2017-12-24 08:41:35
category: Atcoder
tags:
- 基礎
---
這次的題目算簡單，第四題賽中我想到的解法已經很靠近答案了，但後來沒解出來。
A 基礎 AC
B 基礎 AC
C 基礎 AC
D 基礎 賽後AC
pA
比較a*b和c*d的大小
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int main(){
    int a,b,c,d;
    cin>>a>>b>>c>>d;
    a+=b;
    c+=d;
    if(a==c){
        cout<<"Balanced\n";
    }else if(a>c){
        cout<<"Left\n";
    }else{
        cout<<"Right\n";
    }
}
{% endcodeblock %}
pB
這題就照題目給的去做就可以了
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
 
int sod(int x){
    int v=0;
    while(x){
        v+=x%10;
        x/=10;
    }
    return v;
}
 
int main(){
    int n,a,b,ans=0,v;
    cin>>n>>a>>b;
    for(int i=1;i<=n;i++){
        v=sod(i);
        if(v>=a&&v<=b)ans+=i;
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}
pC
題目要求找出一個最長序列A，裡面的數介於[x,y]，且每個數都要是前面所有數的倍數(不能一樣)。
要讓A裡面放越多，所乘的倍數要越小，2是題目所給的條件內最好的數字，所以一直讓x*2，直到x>y時結束即可。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;

int main(){
    unsigned long long x,y,ans=0;
    cin>>x>>y;
    while(x<=y){
        ans++;
        x*=2;
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}
pD
給你一串為由0和1組成的字串，找一段連續區間，將0變成1，1變成0，問你選取的區間長度的最大最小值。
如果相鄰兩數字不一樣，那勢必有一邊要換，所以要找出不一樣的地方，它們之間較大的那一條(先把它們全部變成1在一次轉換也是一種方法)，然後再取最小值就是答案。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
int main(){
    string s;
    cin>>s;
    int ans=s.size();
    for(int i=1;i<s.size();i++){
        if(s[i]!=s[i-1]){
           ans=min(ans,max(i,int(s.size()-i)));
        }
    }
    cout<<ans<<'\n';
}
{% endcodeblock %}