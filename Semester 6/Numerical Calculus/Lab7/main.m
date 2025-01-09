# a, b
xi = [0, 1/3, 1/2, 1];
fi = cos(pi * xi);
d = div_diff(xi,fi) # This is from another lab
xx = linspace(0,1,100);

#c
res = newton_interpolation(d,xi,xx);
plot(xx,cos(pi*xx), xx, res)

#d
xx = 1/5;
res2 = newton_interpolation(d,xi,xx);
res2
cos(pi/5)

# 2
xi = -4:4;
fi = 2.^xi;
xx = 1/2;
# d2 = div_diff(xi, fi);
[res3,n] = aitken(xx, xi,fi)
res3

# 3
xi = [1000,1010,1020,1030,1040,1050];
fi = log10(xi);
d2 = div_diff(xi,fi);
xx = [1001:1:1009];
res4 = newton_interpolation(d2,xi,xx);
res4
