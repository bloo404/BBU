# Solve the problem from the first set here

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

#  Searching for a bigger number than n, that is prime
def searchingForBigger(n):
    n=n+1
    while isPrime(n)==0:
        n=n+1
    return n

# Searching for a smaller number than n, that is prime
def searchingForSmaller(n):
    n=n-1
    while isPrime(n)==0:
        n=n-1
    return n

# Show a number
def show(n):
    print(n)

# Finding what sum of prime numbers is a given n made out of
def goldbach(n): #not the most efficient, but  it works
    ok=int(0)
    k = int(searchingForSmaller(n))
    if n<4 :
        print("n is smaller than 4, the action is not possible.")
    else :
        for p1 in range(2,k+1):
            if isPrime(p1):
                for p2 in range(2,k+1): # n-p1
                    if isPrime(p2)!=0:
                        if p1 + p2==n:
                            ok=1
                            return p1,p2;
    if ok==0:
        print("There was no pair found.") #just in case

# Calculating the frequence of n's digits
def theDigits(n):
    frequence=[0,0,0,0,0,0,0,0,0,0]
    while n!=0:
        i = int(n%10)
        frequence[i]=frequence[i] + 1
        n=n/10

# Creating the smallest number made out of a given n's digits
def smallDigits(frequence):
    m=int(0)
    i=int(1)
    for i in range (1,10):
        while frequence[i]!=0:
            m=m*10+frequence[i]
            if frequence[0]!=0:
                while frequence[0]!=0:
                    m=m*10
                    frequence[0]=frequence[0]-1
            frequence[i]=frequence[i]-1
    return m

# Problems' solutions that contain the callings of the functions

# 1st problem : a prime number bigger than a given n
def Problem1():
    print("Problem 1 : A prime number bigger than a given n")
    n=int(input("Enter a number n : "))
    n=searchingForBigger(n)
    show(n)

# 2nd problem : a given n number is transformed in a sum of two prime numbers
def Problem2():
    print("Problem 2 : Transforming a given n number in a sum of two prime numbers")
    n=int(input("Enter a number n : "))
    p1,p2=goldbach(n)
    print(n,'=',p1,'+',p2)

# 3rd problem : the smallest number made out of a given number's digits
def Problem3():
    print("Problem 3 : The smallest number made out of a given number's digits")
    n=int(input("Enter a number n : "))
    frequence=theDigits(n)
    m=smallDigits(frequence)
    show(m)

# 5th problem : a prime number smaller than a given n
def Problem5():
    print("Problem 5 : A prime number smaller than a given n")
    n=int(input("Enter a number n : "))
    n=searchingForSmaller(n)
    show(n)

# Problems' solutions callings

#Problem1()
Problem2()
#Problem3()
#Problem4()
#Problem5()

