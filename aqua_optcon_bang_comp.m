% 航行器时间最优控制
% 与aqua_optcon_plot 的区别是，它不用计算误差，只是无脑随机跑

% max_TOF 最大飞行时间 s

% X0 初始状态及协态矢量 包含 8个量
%     % 状态量 协态矢量
%     % R       lam11        矢径 m                                            
%     % al      lam12        位置方位角 rad
%     % v       lam21        航行器速率 m/s
%     % q       lam22        航向倾角 rad    惯性航向角theta - 方位角 al 
% h 积分步长 s
%     h  积分步长
%     x_tc 截断距离
%     t4dec 提前减速时间

% 输出的状态是极坐标坐标
% e_total 笛卡尔下的误差
% TOF_opt 运动时间s
%
% lam0      1x4 double
% X0        1x4 double
% max_TOF   double
% h         double
% x_tc      double
% t4dec     double
% x_turncate t_decc 均为 提前定义好的全局变量

%  输出
% x_l_f    1x4 double
%  TOF_opt   double


function [x_l_f,TOF_opt] = aqua_optcon_bang_comp(lam0,X0,max_TOF,h,x_tc,t4dec)
global x_turncate t_decc
x_turncate = x_tc;
t_decc = t4dec;
    X_lam_0 = [X0, lam0];
    % 先不做任何机动积分一步，避免协态矢量计算奇异
    [t1, X1] = rk4_step(@dynamics_free, 0, X_lam_0, h);
    % 整个最优控制的时间段
    tspan = [t1  max_TOF];
    % 接下来就是正经的最优时间bangbang控制
    [t, x_array, ~, ~, ~] = rk4_events(@dynamics_v_lim, tspan, X1, h, @arrival_event);

    TOF_opt = t(end);       % 时间最优的飞行时间
    x_l_f = x_array(end,1:4); % 末状态
end
