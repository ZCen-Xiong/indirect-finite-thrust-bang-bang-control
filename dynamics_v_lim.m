% ����������ѧ ���ٶȹ�С���������Ҫ����t_decc����
% X ���� 8����
% ״̬�� Э̬ʸ��
% R       lam11        ʸ�� m                                            
% al      lam12        λ�÷�λ�� rad
% v       lam21        ���������� m/s
% q       lam22        ������� rad    ���Ժ����theta - ��λ�� al 

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
    % ���ڱ�������裬������������������ٶȣ�����thataת������ֻ��ӳ��q��
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
 % ���ٶȹ�С���������Ҫ����t_decc����   
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

    % Э̬ʸ��
    dX = [dR, dal, dv, dq, dlam11, dlam12, dlam21, dlam22]';
end






