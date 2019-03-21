//Given an array with integers where all elements appear three times except for one. Find out the one which appears only once.
/*Several test cases are given, terminated by EOF.
Each test case consists of two lines. The first line gives the length of array,
 and the other line describes the
 elements. All elements are ranged in .
*/
#include <iostream>
#include <stdio.h>
using namespace std;

int main()
{
	int i, j, count;
	const int N1 = 20, N2 = 10, require = 3;
	while (cin >> count)
	{
		int cnt[N1][N2] = { 0 };

		getchar();//使count数字符无效化
		for (i = 0; i < count; ++i)
		{
			/* code */
			char ch;
			j = 0;
			while ((ch = getchar()) > 47)
				cnt[j++][ch - 48]++;
		}
		for (i = 0; i < N1; ++i)
		{
			/* code */
			for (j = 0; j < N2; ++j)
			{
				/* code */
				if (cnt[i][j] % require)
				{
					/* code */
					cout << (char)(j + '0');
				}
			}
		}
		cout << endl;

	}
	return 0;
}
