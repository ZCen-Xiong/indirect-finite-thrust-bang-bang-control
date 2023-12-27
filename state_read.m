function  [x_ach,y_ach,v,theta] = state_read(x_array)
    x_f = x_array(end,1:4); % ĩ״̬
    R = x_f(1);
    al = x_f(2);
    v = x_f(3);
    q = x_f(4);
    theta = al + q;
    [x_ach,y_ach] = pol2cart(al,R); 
end
