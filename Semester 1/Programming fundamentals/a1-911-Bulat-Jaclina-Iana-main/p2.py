# Solve the problem from the second set here

# Functions that we are using to solve the problems

#  Verifying if a number is a prime number
def isPrime(n):
    i = int(2)
    if n==1 or n==0:
        return 0
    while i<n:
        if n%i==0:
            return 0
        i=i+1
    return 1

# Searching for twin numbers
def twins(n):
    i = int(n);
    ok=int(0)
    i = i + 1
    while ok==0:
        if isPrime(i):
            if isPrime(i+2):
                return i,i+2;
        i=i+1

# Problems' solutions that contain the callings of the functions

# 7th Problem : Determining two twin prime numbers larger than n
def Problem7():
    print("Problem 7 : Two twin numbers larger than a given number n ")
    n = int(input("Enter a number n : "))
    p1,p2=twins(n)
    print(p2,'-',p1,'=2')

# Problems' solutions callings
Problem7()