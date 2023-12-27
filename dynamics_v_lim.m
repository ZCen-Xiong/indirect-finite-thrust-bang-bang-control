% 航行器动力学 加速度过小的情况，需要按照t_decc减速
% X 包含 8个量
% 状态量 协态矢量
% R       lam11        矢径 m                                            
% al      lam12        位置方位角 rad
% v       lam21        航行器速率 m/s
% q       lam22        航向倾角 rad    惯性航向角theta - 方位角 al 

function dX = dynamics_v_lim(t,X)
% X 8x1 double
% t double
%  v_max        double global
%  acc_max      double global
%  w_max        double global
%  v_min        double global
%  t_decc      double global

global t_decc v_max v_min acc_max w_max 
% states
    R  = X(1);
    al  = X(2);
    v  = X(3);
    q = X(4);
% costates
    lam11 = X(5);  % R
    lam12 = X(6);  % alpha
    lam21 = X(7);  % v
    lam22 = X(8);  % q = theta-al 
    % 由于本问题假设，航行器不存在切向加速度，所以thata转弯速率只反映在q上
    dlam11 = lam12*sin(q)*v/(R^2); % R
    dlam12 = 0;                     % alpha
    dlam21 = -lam11*cos(q) - lam12*sin(q)/R;
    dlam22 = lam11*sin(q)*v + lam12*cos(q)*v/R; 
    if lam21 > 0 && v > v_min
        acc = -acc_max;
        if acc*0.1 + v < v_min-1e-4
            acc = (v_min-v)*10;
        end
    elseif lam21 < 0 && v < v_max
        acc = acc_max;
        if acc*0.1 + v > v_max+1e-4
            acc = (v_max-v)*10;
        end
    else
        acc = 0;
    end 
 % 加速度过小的情况，需要按照t_decc减速   
    if t > t_decc
        acc = -acc_max;
        if acc*0.1 + v < v_min-1e-4
            acc = (v_min-v)*10;
        end
    end
    
    if lam22 > 1
        w = -w_max;
    elseif lam22 < -1
        w = w_max;
    else
%         w = -0.3/180*pi * lam22;
        w = 0;
    end   
    
    dR = cos(q)*v;
    dal= sin(q)*v/R;
    dv = acc;
    dq = w;

    % 协态矢量
    dX = [dR, dal, dv, dq, dlam11, dlam12, dlam21, dlam22]';
end






