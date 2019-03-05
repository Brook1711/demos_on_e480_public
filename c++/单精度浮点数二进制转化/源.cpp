#include<iostream>
#include <bitset>
#include<string>
#include <algorithm>

using namespace std;

class my_float {
public:
	my_float(float input);
	void float_to_binary();
	void show_binary()
	{
		cout << "输入浮点数的单精度32位二进制数是：    ";
		cout << single_float_binary <<endl;
	}
	void show_sign()
	{
		cout << "输入浮点数的单精度32位二进制数的符号位是：    ";
		cout << single_float_sign << endl;
	}
	void show_Estr()
	{

		cout << "输入浮点数的单精度32位二进制数的指数位是：    ";
		cout << single_float_Estr << endl;
	}
	void show_Mstr()
	{

		cout << "输入浮点数的单精度32位二进制数的尾数位是：    ";
		cout << single_float_Mstr << endl;
	}


private:
	float single_float;
	string single_float_sign;
	string single_float_Mstr;
	string single_float_Estr;
	string single_float_binary;
};

//将单精度浮点数转化为二进制数
my_float::my_float(float input)
{
	single_float = input;
}

void my_float::float_to_binary()
{
	string sign = (single_float < 0) ? "1" : "0";
	//定义符号位
	single_float = abs(single_float);
	//对数据取绝对值
	int INT = int(single_float);
	//取数据整数部分
	float FLOAT = single_float - INT;
	//取数据小数部分
	string INTstr("");
	//整数部分化为二进制
	string FLOATstr("");
	//小数部分化为二进制
	while (INT)//当整数部分不为零时一直执行
	{
		INTstr += (INT % 2 + '0');
		INT /= 2;
	}
	//以上得出的字符串是反的,以下进行字符串的反转
	reverse(INTstr.begin(), INTstr.end());
	string Estr(8, '0');//初始化指数部分
	string Mstr;//尾数部分
	//下面将尾数转化为二进制数
	for (int i = 1;; i++)
	{
		if (FLOAT == 0.0)
			break;
		float temp = pow(2, -i);
		if (FLOAT>=temp)
		{
			FLOATstr += '1';
			FLOAT -= temp;
		}
		else
		{
			FLOATstr += '0';
		}
	}
	//下面进行移位和指数、尾数的确定
	if (single_float>=1.0)//如果该浮点数大于等于1.0则指数的原码就是（整数尾数-1）
	{
		int offset = INTstr.size() - 1 + 127;//求指数的移码
		int index = 7;//定义指数二进制数下标
		while (offset)
		{
			Estr[index] = offset % 2 + '0';
			offset /= 2;
			index--;
		}
		//尾数为
		Mstr = INTstr.substr(1, INTstr.size() - 1) + FLOATstr;
	}
	else
	{
		//找到小数部分第一个为一的位置
		int index = 0;
		for (int i = 0; i < FLOATstr.size(); i++)
		{
			if (FLOATstr[i]=='1')
			{
				index = i + 1;//index为指数位原码
				break;
			}
		}
		unsigned int offset = index ? (-index + 127) : 0;
		int temp = 7;
		while (offset)
		{
			Estr[temp] = offset % 2 + '0';
			offset /= 2;
			--temp;
		}
		Mstr = FLOATstr.substr(index);
	}
	//对尾数字符串进行填充
	if (Mstr.size()>23)
	{
		Mstr = Mstr.substr(0, 23);//超出23位进行取舍
	}
	else
	{
		Mstr.resize(23,'0');//不到23位补零

	}
	single_float_sign = sign;
	single_float_binary = sign + Estr + Mstr;
	single_float_Estr = Estr;
	single_float_Mstr = Mstr;
}

int main()
{
	float temp;
	cout << "班级：2017211128 姓名：郭旭沨 学号：2017210140" << endl;
	cout << "请输入一个单精度类型的浮点数：" << endl << "样例输入（我的学号）：2017210.140"<<endl;
	my_float my_student_id(2017210.140);
	my_student_id.float_to_binary();
	cout << "样例输出：" << endl;
	my_student_id.show_binary();
	my_student_id.show_sign();
	my_student_id.show_Estr();
	my_student_id.show_Mstr();
	cout << "请输入一个单精度类型的浮点数：" << endl;
	while (cin>>temp)
	{
		my_float my_single_float(temp);
		my_single_float.float_to_binary();
		my_single_float.show_binary();
		my_single_float.show_sign();
		my_single_float.show_Estr();
		my_single_float.show_Mstr();
		cout << "继续输入一个单精度浮点数：" << endl;
	}
	return 0;
}