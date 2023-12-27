% 航行器动力学_无控制
% X 包含 8个量
% 状态量 协态矢量
% R       lam11        矢径 m                                            
% al      lam12        位置方位角 rad
% v       lam21        航行器速率 m/s
% q       lam22        航向倾角 rad    惯性航向角theta - 方位角 al 

function dX = dynamics_free(t,X)
% X 8x1 double
% t double
% states
    R  = X(1);
    al  = X(2);
    v  = X(3);
    q = X(4);

    % 由于本问题假设，航行器不存在切向加速度，所以thata转弯速率只反映在q上
    
    dlam11 = 0; % R
    dlam12 = 0;                     % alpha
    dlam21 = 0;
    dlam22 = 0; 
    dR = cos(q)*v;
    dal= 0;
    dv = 0;
    dq = 0;
    dX = [dR, dal, dv, dq, dlam11, dlam12, dlam21, dlam22]';
end






