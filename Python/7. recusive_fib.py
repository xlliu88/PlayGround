# -*- coding: utf-8 -*-
"""
Created on Wed Mar  8 00:46:26 2017

@author: xunliangliu
"""
import time

def fib1(n):
    if n <= 2:
        return 1
    else:
        return fib1(n-1) + fib1(n-2)

def fib2(n):
    ''' this implementation is much faster'''
    if n <= 2:
        return 1
    f = [0, 1, 1]
    for i in range(3, n+1):
        f.append(f[i-1] + f[i-2])
        
    return f, f[n]

def eff_test(n):

    t0_1 = time.time()
    for t in range(n):
        fib1(t)
    dt_1 = time.time() - t0_1
                    
    t0_2 = time.time()
    for t in range(n):
        fib2(t)
    dt_2 = time.time() - t0_2
                    
    print('\tfib1:\t%.2f seconds\n\tfib2:\t%.2f seconds'%(dt_1, dt_2))
    return dt_1, dt_2
                
x = fib1(10)
y = fib2(10)

eff_test(40)

fib, fibn = fib2(100000)
fib

fibratio = []
for i in range(2, len(fib)-1):
    fibratio.append(fib[i]/fib[i-1])