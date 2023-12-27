% ����������ѧ_�޿���
% X ���� 8����
% ״̬�� Э̬ʸ��
% R       lam11        ʸ�� m                                            
% al      lam12        λ�÷�λ�� rad
% v       lam21        ���������� m/s
% q       lam22        ������� rad    ���Ժ����theta - ��λ�� al 

function dX = dynamics_free(t,X)
% X 8x1 double
% t double
% states
    R  = X(1);
    al  = X(2);
    v  = X(3);
    q = X(4);

    % ���ڱ�������裬������������������ٶȣ�����thataת������ֻ��ӳ��q��
    
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






