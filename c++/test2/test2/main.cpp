#include<stdio.h>
int main() {
	int n = 0, i = 0;
	unsigned long long one, two, three, num;
	while (scanf("%d",&n)!=EOF) {
		one = two = three = 0;
		for (i = 0; i < n; i++) {
			scanf("%LLd",&num);
			three = two&num;
			two = two | one&num;
			one = one | num;
			one = one&(~three);
			two = two&(~three);
		}
		printf("%LLd\n", one);
	}
	return 0;
}
