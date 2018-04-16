<!-- layout: layout -->
title: ITSA58心得
date: 2017-10-29 11:08:32
category: ITSA
tags:
- ITSA
- 基礎
- greedy
- 字串處理
- 樹
- 最短路徑
- 暴力法
---
ITSA58雖然是已經比了好久，但是因為要做新北市模擬賽，所以一直都沒有發文。
結果:
A 基礎 AC
B greedy AC
C 字串處理 樹 AC
D 最短路徑 AC
E 暴力法 AC
好久都沒破台了，XDD。
題解:
pA
水題一題，秒殺。
{% codeblock lang:cpp %}
#include <iostream>
using namespace std;

int main(){
    int n,m;
    cin>>m;
    for(int i=0;i<m;i++){
            cin>>n;
            n=(n/3)*3;
            cout<<(3+n)*(n/3)/2<<'\n';
    }
} 

{% endcodeblock %}
pB
這題是用greedy的概念，先照每條路的起點排序，在按照終點排序，如果一條路的起點小於另一條路的終點，那就合併這兩條路，依此類推。
{% codeblock lang:cpp %}
#include <iostream>
#include <algorithm>
#include <cmath>
using namespace std;

struct road{
    int x,y;
};

bool cmp(road a,road b){
    if(a.x!=b.x)
        return a.x<b.x;
    return a.y<b.y;
}

int main(){
    int n,x,y,ans;
    road arr[10005];
    for(;cin>>n;){
            x=y=ans=0;
            for(int i=0;i<n;i++){
                    cin>>arr[i].x>>arr[i].y;
            }
            sort(arr,arr+n,cmp);
            for(int i=0;i<n;i++){
                    if(arr[i].x>=y){
                        ans+=y-x;
                        x=arr[i].x;
                        y=arr[i].y;
                    }else{
                        y=max(y,arr[i].y);
                    }
            }
            cout<<ans+y-x<<'\n';
    }
} 
{% endcodeblock %}
pC
這題我是用cin來處理輸入，不過善用scanf的[]會比較方便，接下來儲存及判斷的採用heap存點的概念，左右子樹分別為2n和2n+1，就可以得到答案。
{% codeblock lang:cpp %}
#include <iostream>
#include <cmath>
#include <string>
using namespace std;

int main(){
    int m,c,a[100];
    string s;
    cin>>m;
    for(int i=0;i<m;i++){
            cin>>c;
            int x=0,o=0,n=0;
            cin>>s;
            for(int i=0;i<s.size();i++){
                     if(n&&(s[i]>'9'||s[i]<'0')){
                         x++; a[x]=n; n=0;
                    }
                     else if(s[i]<='9'&&s[i]>='0')n=n*10+(s[i]-'0');
            }
            for(int i=1;i<=x;i++){
                    if(i*2<=x&&abs(a[i*2]-a[i])<=c){
                        if(o)cout<<' ';
                        o=1;
                        cout<<char('A'+i-1)<<char('A'+i*2-1);
                    }
                     if(i*2+1<=x&&abs(a[i*2+1]-a[i])<=c){
                        if(o)cout<<' ';
                        o=1;
                        cout<<char('A'+i-1)<<char('A'+i*2+1-1);
                    }
            }
            cout<<'\n';
    }
}
{% endcodeblock %}
pD
看起來就很像是floyd-warshall，就趕快寫一個上去，AC。要寫Dijkstra也可以。
{% codeblock lang:cpp %}
#include <iostream>
#include <cmath>
using namespace std;
const int N=1005;
int n,m,adj[N][N],dp[N][N],x,y;
int main(){
    cin>>n>>m;
    for(int i=0;i<m;i++){
        for(int j=0;j<m;j++){
            cin>>adj[i][j];
            dp[i][j]=100000;
        }
   }
   for(int k=0;k<m;k++){
       for(int i=0;i<m;i++){
           for(int j=0;j<m;j++){
               dp[i][j]=min(dp[i][j],adj[i][k]+adj[k][j]);
           	}
      	}
   }
   for(int i=0;i<n;i++){
           cin>>x>>y;
           cout<<dp[x][y]<<'\n';
    }       
}
{% endcodeblock %}
pE 原本想用DP，但是太難了，所以改用爆搜方式，先建好n!及C(n,m)的表，再遞迴出每種可能，把每種情況加起來就AC了。
{% codeblock lang:cpp %}
#include <iostream>
#include <cstring>
using namespace std;
unsigned long long n,ans,sel[20],noc[20][20],step[20]={1,1};
void sol(unsigned long long s,unsigned long long x,unsigned long long y){
    //cout<<s<<' '<< x<<' '<<y<<'\n';
    //for(int i=1,j;i<=15;i++){cout<<sel[i]<<"+";}cout<<'\n';
    if(y<0)return;
    if(!x){
        if(y)return;
        unsigned long long nn=n,sum=1;
        for(int i=1,j;i<=15;i++){
            for(j=0;sel[i]&&j<sel[i];j++){
                sum*=noc[nn][i];
                nn-=i;
             }
            sum/=step[sel[i]];
        }
        //for(int i=1,j;i<=15;i++){cout<<sel[i]<<"+";}cout<<'\n';
        ans+=sum;
        return;
    }
    for(int i=s;i<=x;i++){
        sel[i]++;
        sol(i,x-i,y-1);
        sel[i]--;
    }
    return;
}

int main(){
    unsigned long long int t,m;
    char ch;
    cin>>t;
    for(int i=2;i<=15;i++){
        step[i]=i*step[i-1];
    }
    for(int i=1;i<=15;i++){
        for(int j=0;j<=i;j++){
            if(!j||i==j)noc[i][j]=1;
            else noc[i][j]=noc[i-1][j-1]+noc[i-1][j];
        }
    }
    memset(sel,0,sizeof(sel));
    for(int i=0;i!=t;i++){
            cin>>n>>ch>>m;
            if(n<m)cout<<"0\n";
            else if(n==1||m==1||n==m)cout<<"1\n";
            else{
                ans=0;
                sol(1,n,m);
                cout<<ans<<'\n';
            }
    }
}
{% endcodeblock %}