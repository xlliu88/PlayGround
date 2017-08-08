# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 19:49:35 2017

@author: xunliangliu
"""

import pylab

def getData(filename):
    weight = []
    dist = []
    with open(filename) as f:
        for line in f.readlines():
            line = line.strip()
            d, w = line.split()
            try:
                dist.append(float(d))
                weight.append(float(w))
            except:
                continue
    return dist, weight

def plotdata(x, y):
#    y, x = getData(filename)
    y = pylab.array(y)
    x = pylab.array(x) * 9.8
    a,b = pylab.polyfit(x,y,1)
    yEst = a*x + b
    # Fit with free degree of 3, looks better on this dataset.
    m,n,o,p = pylab.polyfit(x,y,3)
    yEst2 = m*x**3 + n*x**2 + o*x + p
    pylab.plot(x,y,'b.', label = 'Measured data')
    pylab.plot(x,yEst,'rx--', label = 'Fit curve')
    pylab.plot(x,yEst2,'g1-.', label = 'Fit Curve 2')
    pylab.xlabel('Force(Newton)')
    pylab.ylabel('Distance change')
    pylab.legend(loc = 'best')
    pylab.show()

#def dataFit(x,y):
    
    
    
dist, weight = getData('./MIT6.0_lec17_data/springData.txt')
plotdata(weight, dist)

fit = pylab.polyfit(weight, dist,1)