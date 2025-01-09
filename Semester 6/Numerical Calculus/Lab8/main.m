... Exercise 1)
xi = [0,1,2];
fi = 1./(1 + xi);
d = div_diff(xi,fi);
xx = linspace(0,2,100);
plot(xx,newton_interpolation(d,xi,xx))

dfi = -1./((1+xi).^2);
[zi, d2] = div_diff2(xi,fi,dfi);
hold on
plot(xx,newton_interpolation(d2,zi,xx))
clc

... Exercise 2)
xi = [0,3,5,8,13] % time
fi = [0,225,383,623,993] % distance
dfi = [0,77,80,74,72] % speed
t = 10 % for this much time

display("-------------------")
[zi,d2] = div_diff2(xi,fi,dfi)
value = newton_interpolation(d2,zi,10)
d = div_diff(xi,dfi)
newton_interpolation(d,xi,10)

display("-------------------")
d = div_diff(fi, dfi)
newton_interpolation(d,fi,value)
