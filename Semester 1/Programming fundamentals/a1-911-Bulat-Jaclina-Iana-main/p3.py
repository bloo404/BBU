# Solve the problem from the third set here

# Functions that we are using to solve the problems

# Finding if a given n number is perfect
def isPerfect(n):
    sum = int(1)
    i=int(1)
    cn = int(n)
    for i in range (2,n):
        if n%i==0:
            sum=sum+i
    if sum==cn:
        return 1
    else:
        return 0

# Finding a smaller number than n that is perfect
def smallPerfect(n):
    n=n-1
    while n>2:
        if isPerfect(n):
            return n
        else:
            n=n-1
    return 0

# Problems' solutions that contain the callings of the functions

# 15th problem : finding a perfect number smaller than a given number n
def Problem15():
    print("Problem 15 : A perfect number smaller than n")
    n = int(input("Enter a number n : "))
    x = int(smallPerfect(n))
    if(x==0):
        print("There was no perfect number smaller than n found.")
    else:
        print(x," is a perfect number smaller than n")

# Problems' solutions callings

Problem15()