display('\n Exercise 1 \n')

[I, nf] = romberg(@(x) 1./(2 + sin(x)), 0, pi/2, 10.^(-6), 50)

val = pi*sqrt(3)/9

err = abs(I - val)

... -----------------------------------------------------------

display('\n Exercise 2 \n')

[I2, gn2, gc2] = gaussian_quadrature(@(x)(x.^2 + 1)./(x.^2 + 1), 2, 3)

2 * I

... -----------------------------------------------------------

display('\n Exercise 3 \n')

val = integral(@(x)(exp(cos(x))), 0, pi/4) ... for what pi/4 in -1, 1

[I3, gn3, gc3] = gaussian_quadrature(@(x)(exp(cos(x))), 2, 1)

err = abs(val - I3)

... -----------------------------------------------------------

display('\n Exercise 4 \n')

[I4, gn4, gc4] = gaussian_quadrature(@(x)(sin(x.^2)), 4, 2)

err = abs(val - I4)

... 12 -> 20



