# -*- coding: utf-8 -*-
"""
Created on Mon Jan 16 23:44:21 2017

@author: xinli
"""
import math
def msum(x):
    # to caculate the summary of 1 to x
    if x == 1:
        return x
    else:
        return x + msum(x-1)

def lsum(lst):
    # return the summary of a list
    if llen(lst) == 1:
        return lst[0]
    else:
        return lst[0] + lsum(lst[1:])
    
    
    
def ndig(x):
    # return the digits of a integer
    if x < 10:
        return 1
    else:
        return 1 + ndig(x//10)
        
        
def gcd(x,y):
    # to caculate the greatest common division
    big = max(x,y)
    small = min(x,y)
    if big % small == 0:
        return small
    else: 
        return gcd(small, big % small)
        
def llen(x):
    # return the length of a list
    if x == []:
        return 0
    else:
        return 1 + llen(x[1:])

def maplist(fun, lst):
    # apply a function to a list and return a list
    #not working
    if lst == []:
        return []
    else:
        return list(fun(lst[0])) + (maplist(fun,lst[1:]))
        
print(msum(100))

print(ndig(3543544))

print(gcd(33,121))
print(gcd(3249,5849))
print(gcd(123*34, 34*324))

lst = [1,2,3,4,6,10]
lst2 = ["ab","1234", "laifjei"]
#print("length of list is: ", llen(lst))
#print("summary of list is: ", lsum(lst))

lstsqrt = maplist(math.sqrt,lst)
lstsqrt = [math.sqrt(i) for i in lst] #equal to the previous one
print(lstsqrt)
