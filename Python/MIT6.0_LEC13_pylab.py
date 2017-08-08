# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 21:48:21 2017

@author: xunliangliu
"""

import pylab
import random as rnd
import math
import statistics

x = list(range(100))
y = list(range(1,101))
y2 = [math.log(i) for i in y]

pylab.figure(1)

pylab.xlabel = 'Number'
pylab.ylabel = 'log'
pylab.plot(x,y2)
pylab.plot(x,y)
pylab.show()