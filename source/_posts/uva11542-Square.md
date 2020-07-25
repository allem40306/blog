---
title: uva11542 Square
abbrlink: df0d
date: 2020-07-25 11:50:17
category: UVa
tags:
- UVa
- math
- prime
- gauss elimination
- 程式競賽選修課
- 108 下
---
[題目連結](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=2537)
* 題意：給定 $N$ 個數，問有幾種組合，組合內數計乘積為完全平方數，空集合不算一種。
<!-- more -->
* 題解：如果要是完全平方數，乘積內的每個質因數都是偶數個，對於每個質因數，以算式寫就是 $x_1+x_2+x_3+...+x_n\equiv 0 \mod 2$，可以轉變成用 $\oplus(xor)$ 表示的式子:$y_1\oplus y_2\oplus y_3\oplus ...\oplus y_n=0,y_i=x_i\mod 2$。所有質因數可形成一個 $xor$ 的聯立方程式，利用高斯消去法，最後結果有 $k$ 個 free variable(自由變量)，那麼答案就是 $2^k-1$(扣除空集合)。
```cpp=
#include <bits/stdc++.h>
using namespace std;
typedef long long LL;
const LL N=505;
const int M=505;
vector<LL>p;
bitset<N>is_notp;
vector<int>v[M];
int n;

void PrimeTable(){
    is_notp.reset();
	is_notp[0] = is_notp[1] = 1;
	for (LL i = 2; i < N; i++){
		if (is_notp[i])continue;
		p.push_back(i);
		for (int j=0;i*p[j]<N&&j<p.size();j++){
			is_notp[i*p[j]] = 1;
			if(i%p[j]==0)break;
		}
	}
    for(int i=0;i<M;i++){
        v[i].resize(p.size());
    }
}

void init(){
    for(int i=0;i<M;i++){
        for(int j=0;j<v[i].size();j++){
            v[i][j]=0;
        }
    }
}

void debug(){
    for(int i=0;i<n;i++){
        for(int j=0;j<5;j++){
            cout<<v[i][j]<<' ';
        }
        cout<<'\n';
    }
    cout<<'\n';
}

bool cmp(vector<bool> a,vector<bool> b){
    for(int i=0;i<min(a.size(),b.size());i++){
        if(a[i]!=b[i]){
            return a[i]>b[i];
        }
    }
    return a.size()<b.size();
}

int sol(int row, int col){
    int i = 0, j = 0;
    while(i < row && j < col){
        int r = i;
        for(int k = i; k < row; k++){
            if(v[k][j]){
                r = k;
                break;
            }
        }
        if(v[r][j]){
            if(r != i){
                for(int k = 0; k <= col; k++)swap(v[r][k], v[i][k]);
                
            }
            for(int k = i + 1; k < row; k++){
                if(v[k][j]){
                    for(int kk = i; kk <= col; kk++)v[k][kk] ^= v[i][kk];
                }
            }
            i++;
        }
        j++;
        // debug();
    }
    return i;
}

int main(){
    PrimeTable();
    int t;
    cin>>t;
    while(t--){
        cin>>n;
        init();
        LL x;
        int mx = 0;
        for(int i=0;i<n;i++){
            cin>>x;
            for(int j=0;j<p.size();j++){
                while(x%p[j]==0){
                    v[j][i]^=1;
                    mx = max(mx, j);
                    x/=p[j];
                }
            }
        }
        int ans=sol(mx + 1, n);
        cout<<((1LL<<(n-ans))-1)<<'\n' ;
    }
}
```