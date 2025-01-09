# 1a) plot e^x and its Taylor polynomial of degree 1 2 3 on [-3,3]

pkg load symbolic
syms x

##f = exp(x)
##T1f = taylor(f, x, 0, 'Order', 2) %f, x, x0, order, degree + 1
##T2f = taylor(f, x, 0, 'Order', 3)
##T3f = taylor(f, x, 0, 'Order', 4)
##T4f = taylor(f, x, 0, 'Order', 5)
##
##ezplot(f,[-3,3])
##hold on
##ezplot(T1f,[-3,3])
##ezplot(T2f,[-3,3])
##ezplot(T3f,[-3,3])
##ezplot(T4f,[-3,3])
##
### 1b) approximate e with 6 digits
##
####vpa(exp(1),7)
####subs(T1f,x,1)
####
####for k=6:20
####  Tkf = taylor(f, x, 0, 'Order', k);
####  disp(k);
####  vpa(subs(Tkf,x,1),7)
####end
##
### 2 Taylor polynomials
##
##f = sin(x)
##
##T3 = taylor(f,x,0,'Order',4)
##T5 = taylor(f,x,0,'Order',8)
##
##ezplot(f,[-pi,pi])
##hold on
##ezplot(f,[-pi,pi])
##
### b) sin(pi/5)
##vpa(sin(pi/5),6)
##
### c) sin(10pi/3)
##
##vpa(sin(10*pi/3),6)
##
### or
##vpa(sin(-pi/3),6);


# 3a)

clf

f1 = log(1 + x)
f2 = taylor(f,x,0,'Order',3)
f3 = taylor(f,x,0,'Order',6)

##ezplot(f,[-0.9,1])
##hold on
##ezplot(f2,[-0.9,1])
##ezplot(f3,[-0.9,1])
##clf

# b)
T2 = taylor(f1,x,0,'Order',8)
ezplot(T2,[-0.9,1])
hold on

# c)

f2 = log(1 - x)
T = taylor(f2,x,0,'Order',8)
ezplot(T,[-0.9,1])

# d)
f = log((1+x)/(1-x))

for k=1:20
  T = taylor(f1,x,0,'Order',k);
  T2 = taylor(f2,x,0,'Order',k);
  T3 = T - T2 ;
  vpa(subs(T3,x,1/3),10)
end

ezplot(T3, [-0.9,1])

# e)
elem = 1/3
T4 = taylor(f,x,0,'Order',8)
ezplot(T4,[-0.9,1])



# clf
