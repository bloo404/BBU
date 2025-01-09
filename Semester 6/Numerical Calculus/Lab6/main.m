lagrange_interpolation([1,2,3] , [1,4,9] , 5)
lagrange_interpolation([1,2,3] , [1,4,9] , [5,3])

# Lagrange interpolation
xi = linspace(-2, 4, 10);
fi = (xi + 1)./(3*xi.^2 + 2*xi + 1);
x = linspace(-2,4,500);
f = (x + 1)./(3*x.^2 + 2*x + 1);
L9f = lagrange_interpolation(xi, fi, x);

plot(x,f,x,L9f,'g',xi,fi,'o')

plot(x, abs(f - L9f))

max(abs(f - L9f))

# Lagrange Barycentric formula
xi = 1980:10:2020
fi = [4451, 5287, 6090, 6970, 7821]

y = barycentric_formula(xi,fi,[2005,2015])
abs(y - [6474, 7405])./abs([6474,7405])

# Square root of 118 approximated with 3 decimals with Lagrange interpolation
xi = [121 144 169 100 81]
fi = [11 12 13 10 9]
barycentric_formula(xi, fi, 118)

