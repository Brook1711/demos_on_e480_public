#include <iostream>

using namespace std;

bool judgement(double x[], double y[], int count_points)
{
	bool flag = 0;
	for (int i = 0; i < count_points && !flag; ++i)
	{
		/* code */
		for (int j = i + 1; j < count_points && !flag; ++j)
		{
			/* code */
			for (int k = j + 1; k < count_points && !flag; ++k)
			{
				if ((y[k] - y[i]) / (x[k] - x[i]) == (y[j] - y[i]) / (x[j] - x[i]))
					flag = 1;
			}
		}
	}
	return flag;
}
int main()
{
	int count_case, count_points;
	double x[100], y[100];
	cin >> count_case;
	for (int i = 0; i < count_case; ++i)
	{
		x[100] = { 0 }, y[100] = { 0 };
		cin >> count_points;
		for (int i_points = 0; i_points < count_points; ++i_points)
		{
			/* code */
			cin >> x[i_points] >> y[i_points];
		}
		bool flag = judgement(x, y, count_points);
		if (flag)
			cout << "Yes" << endl;
		else
			cout << "No" << endl;
	}
	return 0;
}
