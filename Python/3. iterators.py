# -*- coding: utf-8 -*-
"""
Created on Wed Feb  8 13:18:07 2017

@author: xunliangliu
"""


# iter() function
ir = iter(range(10)) # similar to generator
next(ir)             # retrieve one by one
list(ir)             # container will be empty after this command
[i for i in ir]      # another way of list convert


lst = list("APPLE")
s = iter(lst)
next(s) # will return items in lst one by one

# generator
def counter(start,stop):
    for i in range(start,stop + 1):
        yield i
        
def inf_counter():
    'it will count infinitantly'
    x = 0
    while True:
        x += 1
        return x
        
c = counter(1,10)
nc = next(c) # retrieve c items one by one
lc = list(c) # convert it to a list
lc2 = [i for i in c] # another way to convert it to list

# generator comprehension
sumsquare = sum(i*i for i in range(10)) # use '(' instead of '['
mtx_mul = (x * y for x, y in zip(range(1,10,2),range(2,11,2))) # mtx_mul is a generator
sum_cm = sum(mtx_mul)