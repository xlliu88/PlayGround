# -*- coding: utf-8 -*-
"""
Created on Sat Feb 25 16:36:03 2017

@author: xunliangliu
"""
'''
Normal distribution:
    nice mathemetical proporties
        can be completely characterized by: mean & SD
        mean & SD can be used to caculate confidence interval.
    many natrually accorring examples
    
    Empirical rule
        68% of data within 1 sd of mean
        95% of data within 2 sd of mean
        99.7% in 3 sd of mean
        
    standard error (SE): estimate of standard deviation
        if P = % sampled, n = sample size
        SE = (p*(1-p)/n)**0.5
        '''
        
import math
import random

def stdDev(X):
    m = sum(X)/len(X)
    ss = sum([(x-m)**2 for x in X])
    return math.sqrt(ss/len(X))


def flip(n):
    res = []
    for i in range(n):
        res.append(random.choice([0,1]))
    return res

def percent(res):
    ''' caculate the percentage of head and tail'''
    h = sum(res)/len(res)
    t = 1 - h
    return h,t

def flitTest(nFlips, nTrials):
    for f in range(nTrials):
        res = flip(nFlips)
        std = stdDev(res)
    