# -*- coding: utf-8 -*-
"""
Created on Sat Feb  4 12:43:47 2017

@author: xunliangliu
"""

import random 
from random import Random
from random import SystemRandom

# random module has two class: Random() and SystemRandom()
# functions in random class are actually bound to hidden instance of Random() class
rng = Random() # set rng as a Random class.
rngS = SystemRandom() # set rngS as a SystemRandom class


a = rng.randint(1,100)
b = random.randint(1,100) # the two expression are equel.

# define a generator
def r(k):
    for i in range(k):
        yield random.randint(0,256)
rx = r(10)

import tuple_list #import self-defined module; it has to be in the working directory
import Redball

from random import *  # in this manner, you can use the function directly.
                      # can use this statment to avoid name conflict. 
                      # it could be problemtic due to introducing unknow names
# for example:
choice(rx) # equel to random.choice(a)
sample(rx,3) #equel to random.sample(a,3)

for i in range(20000,30000):
    print(chr(i),end=" ")
print()