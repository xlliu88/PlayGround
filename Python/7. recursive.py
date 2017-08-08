# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 16:18:53 2017

@author: xunliangliu
"""

class point:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
        
def Int_Mul(x,y):
    if x == 0:
        return 0
    elif x == 1:
        return y
    elif x == -1:
        return -y
    elif x < -1:
        return -y + Int_Mul(x+1, y)
    else:
        return y + Int_Mul(x-1,y)
        
#print(mul(0,5))
#print(mul(5,0))
print(Int_Mul(-4,3))
#print(mul(5,-3))

import math as m
print(m.pi)

p = point()
q = point(x=3,y=4)
p.x = 1.2
p.y = 3.4
print(q.x, q.y)
print(p.x, p.y)
print(p.__init__)