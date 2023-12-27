function [value,isterminal,direction] = arrival_event(t,x)
    % r_se为中间通信段在首尾连线上的的截距
    % X 1x8 double
    % t double
    % x_turncate double global
    global x_turncate
    R = x(1);
    al = x(2);
    value = R * cos(al) - x_turncate;
    direction = 0;
    isterminal = 1;
end