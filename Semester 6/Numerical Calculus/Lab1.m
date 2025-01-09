# A = [1,2; 3,4];
# A^2;
# A.^2;

# Exercise 1
p = [1, -5, -16, 16, -17, 21];
disp("P poly has coefficients:\n");
disp(p);

# a)
x = -4:0.1:7.2;
px = polyval(p,x);
plot(x,px);

# b)
c = polyval(p,-2.5);
disp("\n p(2.5) \n");
disp(c);

# c)
r = roots(p);
disp("Roots are: \n");
disp(r);

# Checking roots
# Real numbers
disp(polyval(p, 7));
disp(polyval(p, -3));
disp(polyval(p, 1));

clear all

# Exercise 2

# f g h
x = linspace(0, 2*pi, 1000);
# plot(x,sin(x),x,sin(2*x),x,sin(3*x));

# defining functions

f = @(x)sin(x);
fplot(f, [0,2*pi]);
hold on
g = @(x)sin(2*x);
fplot(g, [0,2*pi]);
h = @(x)sin(3*x)
fplot(h, [0,2*pi])
hold off

# plot all in same frame but different pages
subplot(3,1,1);
fplot(f, [0,2*pi]);
subplot(3,1,2);
fplot(g, [0,2*pi]);
subplot(3,1,3);
fplot(h, [0,2*pi]);

clear all;
clf;
clc;

# Exercise 3

R = 3.8;
r = 1;

t = linspace(0,10*pi,1000);
x = (R+r)*cos(t)-r*cos((R/r + 1)*t);
y = (R+r)*sin(t)-r*sin((R/r + 1)*t);

plot(x,y);

clear all

# Exercise 4
##x = linspace(-2,2);
##y = linspace(0.5, 4.5);
##
##[x,y] = meshgrid(x,y);
##
##f = sin(exp(x)) .* cos(log(y)); # multiplying 2 arrays
##mesh(x,y,f);

# plot3(x,y,f);

xlabel "x axis";
ylabel "y axis";
zlabel "f axis";

##clear all
##clf
##clc

# Exercise 5

s = 2;
n = 2;

for i = 1:n
  s = 1 + 1/s;
end

disp(s);

s = 2;
n = 10;

for i = 1:n
  s = 1 + 1/s;
end

disp(s);

s = 2;
n = 2024;

for i = 1:n
  s = 1 + 1/s;
end

disp(s); # 1.618 = (1 + rad(5))/2 => golden ratio

