# Exercise 1)

xi = -2:4;
fi = (xi+1)./(3*xi.^2+2*xi+1);

plot(xi,fi,'o');

x = linspace(-2,4);
f = (x+1)./(3*x.^2+2*x+1);

hold on

plot(x,f);

d = div_diff(xi,fi);

plot(x,newton_interpolation(d,xi,x));

dfi = (-3*xi.^2-6*xi-1)./((3*xi.^2+2*xi+1).^2);
[zi,d2] = div_diff2(xi,fi,dfi);

plot(x,newton_interpolation(d2,zi,x));

s = spline(xi,fi,x);

plot(x,s);

clf

# Exercise 2)
xi = [-1,-1/2,0,1/2,1,3/2];
fi = xi.*sin(pi*xi);

x = linspace(-1,3/2);
s = spline(xi,fi,x);

plot(x,s,xi,fi,'o');
hold on

sc = spline(xi,[pi, fi, -1],x);
plot(x, sc)

p = pchip(xi,fi,x)
plot(x,p)
plot(x,f)

clf

# Exercise 3)
xi = [0.5,1.5,2,3,3.5,4.5,5,6,7,8];
fi = [5,5.8,5.8,6.8,6.9,7.6,7.8,8.2,9.2,9.9];
scatter(xi,fi);
p = polyfit(xi,fi,1);
hold on

plot([0.5, 8],polyval(p,[0.5,8]));

display("Norm");
norm(fi-polyval(p,xi))

display("Polyval");
polyval(p, 4)

clf

# Exercise 4)




