
#include<stdio.h>

#define clr(a) memset(a,0,sizeof a)

int main(){

    int i,j,cnt[20][20]={0},n;

    while(scanf("%d",&n)!=EOF){

        clr(cnt);

        getchar();

        for(i=0;i<n;i++){

            char ch;

            j=0;

            while((ch=getchar())>47)

                cnt[j++][ch-48]++;

        }

        for(i=0;i<20;i++)

            for(j=0;j<20;j++)

                if(cnt[i][j]%3)

                    printf("%c",j+'0');

        printf("\n");

    }

    return 0;

}
