# -*- coding: utf-8 -*-
"""
Created on Mon Feb 27 17:35:36 2017

@author: xunliangliu
"""
import random
import pylab
import math

def stdDev(X):
    m = sum(X)/len(X)
    ss = sum([(x-m)**2 for x in X])
    return math.sqrt(ss/len(X))

def cmpGuess(guess, maxVal):
    """Assumes that guess is an integer in range(maxVal). 
    returns -1 if guess is < than the magic number, 0 if it is equal to the
    magic number and 1 if it is greater than the magic number. The
    magic number is in range(maxVal)."""
    if guess < magNum: 
        return -1
    elif guess > magNum:
        return 1
    else:
        return 0


def findNumber(maxVal):
    """Assumes that maxVal is a positive integer. Returns a
    number, num, such that cmpGuess(num, maxVal) == 0.""" 
    global magNum
    magNum = random.randint(0,maxVal)
    low = 0
    up = maxVal
    numGuess = 0
    while True:
        guess = random.randint(low, up)
        res = cmpGuess(guess, maxVal)
        numGuess += 1
        #print(low, up, guess, magNum, numGuess)
        if res == -1:
            low = guess + 1
            continue
        elif res == 1:
            up = guess - 1
            continue
        else:
            #print('%d\t%d' %(guess, numGuess))
            return guess, numGuess

stepsAll = []
SDs = []
xx = []
for i in range(8):
    steps = []
    xx.append(10**i)
    for r in range(20):
        num, step = findNumber(10**i)
        steps.append(step)
    stepMean = sum(steps)/20
    stepsAll.append(stepMean)
    stdev = stdDev(steps)
    SDs.append(stdev)

print(stepsAll)
pylab.plot(xx, stepsAll, 'go', label = 'mean steps')
pylab.plot(xx, SDs, 'r.', label = 'stdev')
pylab.xlabel('Guess Range')
pylab.ylabel('Steps of Guess')
pylab.xscale('log')
pylab.legend(loc = 'best')
pylab.show()
 
