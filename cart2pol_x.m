% µÑ¿¨¶û×ª¼«×ø±ê
function pol = cart2pol_x(cart)
        x = cart(1);
        y = cart(2);
        R = sqrt(x^2+y^2);
        al = atan2(y,x);
        pol = [R,al];
end