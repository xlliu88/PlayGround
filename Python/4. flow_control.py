# -*- coding: utf-8 -*-
"""
Created on Thu Feb 16 20:28:48 2017

@author: xunliangliu
"""

### for - else clause:
### else clause only excuted if for loop ended without a break;

needle = 'd'
hay = list('abcd')

for letter in hay:
    if letter == needle:
        print ('found')
        break
else: # if no break occured
    print ('not found')
    

### try - exception - else - finally
a = '123'
try:
    x = int(a)
except:
    print('convert "%s" failed' % a)
else: # if no exception happened
    print('Convert successful!')
finally: # will always be excuted
    print ('done')
    
    
