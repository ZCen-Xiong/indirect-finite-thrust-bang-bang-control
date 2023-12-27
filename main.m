% clear;
clc;
close all;
global v_max acc_max w_max  v_min
% 笛卡尔下初始位置
tic
cart_0= [0 0];  
v_0 = 5.14; th_0 = 0;
v_max = 6;
v_min = 2;
v_comm = 2;
h = 0.1;
% 首先确定通讯段
th_comm = 1/6*pi;
ts = 480; te = 570;  tf = 1200;
acc_max = 0.04;
w_max = 0.02;
cart_s = [2.599833698300022e+03,-38.918918918918910];
% 转为极坐标
pol_0 = cart2pol_x(cart_0);
q_0 = th_0 - pol_0(2);
pol_s = cart2pol_x(cart_s);

% 通讯段约束
xs.R = pol_s(1);
xs.al = pol_s(2);
xs.v = [0 2];
xs.th = [1,5]/6*pi;
lam_0 = [1 -2 10 9];
%% continue


X0 = [pol_0, v_0, q_0];
h = 0.1;
x_tc = cart_s(1);
t4dec = ts - 100;
tic 
[x_lam,tof] = aqua_optcon_bang_comp(lam_0,X0,ts,h,x_tc,t4dec);
toc
