%dsp实验
%x(t)=cos(16 pi t); Wc = 16pi rad/s
%1、设定采样周期T并说明原因
%T <= 1/(2*8) ; 设T = 1/32
T = 1/32;
%2、x(n)=cos(16 pi n T)
%该序列的周期为 2pi/(16pi * (1/32)) = 4
%该序列的周期为 2pi/(16pi * (1/128)) = 16
%3、绘制十个周期内x(n)的取值情况
n = 0 : 1 : 40;

x_n = cos(16*pi*T*n);

figure('NumberTitle', 'off', 'Name', 'draw x(n) x1(n) X(k)');
subplot(3, 1, 1);
stem(n, x_n);xlabel('n');ylabel('x(n)');

%4、令x1(n)表示x(n)的主值序列，绘制|DFT(x1(n))|,解释取值情况
x1_n = x_n(1 : 4);
subplot(3, 1, 2);
stem(0 : 1 : 3, x1_n);xlabel('n');ylabel('x1(n)');

%定义DFT矩阵W4
W4 = dftmtx(4)
%计算DFT(x1(n))结果
X1_k = abs(W4 * x1_n');
subplot(3, 1, 3);
stem(0 : 1 : 3, X1_k);xlabel('n');ylabel('X1(k)');
%可见X(k)只有在n=1、3时取值，这是因为原函数是一个余弦函数，其在频域上只在W = 16pi 、-16pi处取值
%因此当对频域抽样操作时也只有在对应点上有值

%5、令x1_n_2 = x_n(2 : 5) x1_n_3 = x_n(3 : 6) x1_n_4 = x_n(4 : 7)
%分别选取不同起点截取一个周期
x1_n_2 = x_n(2 : 5); X2_k = abs(W4 * x1_n_2');
x1_n_3 = x_n(3 : 6); X3_k = abs(W4 * x1_n_3');
x1_n_4 = x_n(4 : 7); X4_k = abs(W4 * x1_n_4');

figure('NumberTitle', 'off', 'Name', 'choose differrent start piont');
subplot(3,1,1);
stem(0 : 1 : 3, X2_k);xlabel('n');ylabel('X1_2(k) ');
subplot(3,1,2);
stem(0 : 1 : 3, X3_k);xlabel('n');ylabel('X1_3(k) ');
subplot(3,1,3);
stem(0 : 1 : 3, X4_k);xlabel('n');ylabel('X1_4(k)');
%可以发现几张图表和之前的DFT相比完全相同，这是因为题中变换实际上相当于对原序列进行了一次时移
%而时域变换相对于原DFT只是乘上了一个旋转因子——WN^(n0*k),这样原DFT的幅度保持不变

%6、设x1_2n(n)

x1_2N = x_n(1:8);
W8 = dftmtx(8);
X1_2N_k = abs(W8 * x1_2N');

figure('NumberTitle', 'off', 'Name', 'the DFT amount is 2N');
subplot(2, 1, 1);
stem(0 : 1 : 7, x1_2N);xlabel('n');ylabel('x1_2_N(k)');

subplot(2, 1, 2);
stem(0 : 1 : 7, X1_2N_k);xlabel('n');ylabel('X1_2_N(k)');
%可见取两周期的时域序列相当于在频域进行上取样

%7、设x1_n_5 = x_n(1 : 5) x1_n_6 = x_n(1 : 6) x1_n_7 = x_n(1 : 7)
W5 = dftmtx(5);
W6 = dftmtx(6);
W7 = dftmtx(7);

x1_n_5 = x_n(1 : 5); X1_5 = abs(W5 * x1_n_5');
x1_n_6 = x_n(1 : 6); X1_6 = abs(W6 * x1_n_6');
x1_n_7 = x_n(1 : 7); X1_7 = abs(W7 * x1_n_7');

figure('NumberTitle', 'off', 'Name', 'the DFT amount is 5 6 7');
subplot(3, 1, 1);
stem(0 : 1 : 4, X1_5);xlabel('n');ylabel('X1_5');
subplot(3, 1, 2);
stem(0 : 1 : 5, X1_6);xlabel('n');ylabel('X1_6');
subplot(3, 1, 3);
stem(0 : 1 : 6, X1_7);xlabel('n');ylabel('X1_7');