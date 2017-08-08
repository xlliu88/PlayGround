# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 16:50:14 2017

@author: xunliangliu
"""
'''
a simulation to estimate pi value
basic model:
    image there's a 1x1 square with a R=0.5 circle inside.
    when throw needles into this square, the probabilities that the needle
    lands in the circle vs in the square is equal to the ratio of area of
    circle vs square
    '''
    
import random
import math
import pylab

def stdDev(X):
    m = sum(X)/len(X)
    ss = sum([(x-m)**2 for x in X])
    return (ss/len(X))**0.5
    
def dropNeedle(nNeedles):
    inCircle = 0
    
    for n in range(nNeedles):
        x, y = random.uniform(0,1), random.uniform(0,1)
        #print (x,y)
        toCenter = ((x-0.5)**2 + (y-0.5)**2)**0.5
       # toCenter = (x**2 + y**2)**0.5 ???
        if toCenter <= 0.5:
            inCircle += 1
    return 4*inCircle/nNeedles
    
def piEst(nNeedles, nTrials, precision = 0.01):
    sDev = precision
    pis = []
    sDevs = []
    count = 0
    while sDev >= (precision/4.0):
        count += 1
        est = []
        for t in range(nTrials):
            est.append(dropNeedle(nNeedles))
        sDev = stdDev(est)
        sDevs.append(sDev)
        print("Standard Dev:\t", round(sDev,3))
        currEst = sum(est)/len(est)
        pis.append(currEst)
        print("Estimated Pi:\t", round(currEst,5))
        if count > 100:
            break
    return currEst, pis, sDevs
    
pi, estlist, sDevlist = piEst(1000,10)
#estlist = [math.fabs(x-3.1415926) for x in estlist]
sDevlist = [x*50 for x in sDevlist]

pylab.plot(estlist, 'r.', label = 'pi estimate')
pylab.plot(sDevlist, 'g+', label = 'Standard Dev')

pylab.ylabel('Estimations')
pylab.show()

print(pi)