f = @(x) 1./(x + 1);
a = 0;
b = 1;
n = 30;

display("Comp rectangle")
I_rectangle = comp_rectangle(f,a,b,n)
display("\n")

... ---------------------
display("Comp trapezoid")
I_trapezoid = comp_trapezoid(f,a,b,n)
display("\n")

... ---------------------
display("Simpsons")
I_simpsons = simpsons(f, a, b, n)
display("\n")

... ---------------------

display("Adquad")
err = 1e-6;
method = @simpsons;
m = 10;

I_adquad = adquad(f, a, b, err, method, m)
display("\n")

... ---------------------

