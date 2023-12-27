% ������ʱ�����ſ���
% ��aqua_optcon_plot �������ǣ������ü�����ֻ�����������

% max_TOF ������ʱ�� s

% X0 ��ʼ״̬��Э̬ʸ�� ���� 8����
%     % ״̬�� Э̬ʸ��
%     % R       lam11        ʸ�� m                                            
%     % al      lam12        λ�÷�λ�� rad
%     % v       lam21        ���������� m/s
%     % q       lam22        ������� rad    ���Ժ����theta - ��λ�� al 
% h ���ֲ��� s
%     h  ���ֲ���
%     x_tc �ضϾ���
%     t4dec ��ǰ����ʱ��

% �����״̬�Ǽ���������
% e_total �ѿ����µ����
% TOF_opt �˶�ʱ��s
%
% lam0      1x4 double
% X0        1x4 double
% max_TOF   double
% h         double
% x_tc      double
% t4dec     double
% x_turncate t_decc ��Ϊ ��ǰ����õ�ȫ�ֱ���

%  ���
% x_l_f    1x4 double
%  TOF_opt   double


function [x_l_f,TOF_opt] = aqua_optcon_bang_comp(lam0,X0,max_TOF,h,x_tc,t4dec)
global x_turncate t_decc
x_turncate = x_tc;
t_decc = t4dec;
    X_lam_0 = [X0, lam0];
    % �Ȳ����κλ�������һ��������Э̬ʸ����������
    [t1, X1] = rk4_step(@dynamics_free, 0, X_lam_0, h);
    % �������ſ��Ƶ�ʱ���
    tspan = [t1  max_TOF];
    % ��������������������ʱ��bangbang����
    [t, x_array, ~, ~, ~] = rk4_events(@dynamics_v_lim, tspan, X1, h, @arrival_event);

    TOF_opt = t(end);       % ʱ�����ŵķ���ʱ��
    x_l_f = x_array(end,1:4); % ĩ״̬
end
