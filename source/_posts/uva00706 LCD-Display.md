---
<!-- layout: layout -->
title: UVa00706 LCD-Display  (ZeroJudgec135)
category: UVa
tags:
  - UVa
  - Zerojudge
  - 建表
abbrlink: 186d
date: 2017-12-22 00:00:00
---
連結1: https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=24&page=show_problem&problem=647
連結2: https://zerojudge.tw/ShowProblem?problemid=c135
題目大意: 這題是給你長度及一串數字，要你印出指定長度的數字(像小綠人倒數的數字)。
<!-- more -->
作法:我先建表(style)，把每個數字分五層，紀錄要不要顯示，一三五層是橫的如果是0就不輸出空白，1輸出橫線；二四層為直線(左右兩邊)，0(兩邊空白)，1(右邊直線)、2(左邊直線)、3(兩邊直線)，直線判斷的時候是用位元運算來實作。
{% codeblock lang:cpp %}
#include <bits/stdc++.h>
using namespace std;
int main(){
    int m,a[10],ar=0;
    int style[10][5]={1,3,0,3,1,0,1,0,1,0,1,1,1,2,1,1,1,1,1,1,0,3,1,1,0,1,2,1,1,1,1,2,1,3,1,1,1,0,1,0,1,3,1,3,1,1,3,1,1,1};
    string s;
    while(cin>>m>>s,(s!="0")||m){
        ar=0;
        for(int i=s.size()-1;i>=0;i--){
            a[ar]=(s[i]-'0');
            ar++;
        }
        for(int i=0;i<5;i++){
            if(i&1){
                s="";
                for(int j=ar-1;j>=0;j--){
                    s+=((style[a[j]][i]&2)?'|':' ');
                    for(int k=0;k<m;k++)s+=' ';
                    s+=((style[a[j]][i]&1)?'|':' ');
                    if(j)s+=' ';
                }
                for(int j=0;j<m;j++)cout<<s<<'\n';
            }else{
                for(int j=ar-1;j>=0;j--){
                    cout<<' ';
                    for(int k=0;k<m;k++){
                        cout<<((style[a[j]][i])?'-':' ');
                    }
                    cout<<' ';
                    if(j)cout<<' ';
                }
                cout<<'\n';
            }
        }
        cout<<'\n';
    }
}
{% endcodeblock %}