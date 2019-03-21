#include<iostream>
#include<stdio.h>
using namespace std;
void show(int *p,int n)
{
for (int i=0; i<n; i++)
{
cout<<"Êý×Ö£º"<<p[i]<<endl;
}

}
int main(void)
{
int *p = new int[4];
for(int i=0; i<4; i++)
{
p[i] = i;
}
show(p,4);
return 0;
}
