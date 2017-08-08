# -*- coding: utf-8 -*-
"""
Created on Wed Feb 22 22:05:58 2017

@author: xunliangliu
"""
import random
import pylab

x = [1,2,3,4,5,10,50,100,1000,10000]
y1 = [100.0, 50.0, 66.67, 75.0, 60.0, 40.0, 40.0, 50.0, 49.5, 49.27]
y2 = [0.0, 50.0, 33.33, 50.0, 0.0, 40.0, 56.0, 51.0, 49.2, 50.05]

# Basic plot
pylab.plot(x, y1, 'go-', label = 'line 1', linewidth = 1.5) # see below for style options
pylab.plot(x, y2, 'b^:', label = 'line 2') # plot multiple lines in one graph
pylab.xscale('logit') # 'linear', 'log', 'logit', 'symlog'
pylab.ylim(0,100)   # set y limit
pylab.title('DEMO OF PyLAB')
pylab.xlabel('Number of Trials')
pylab.ylabel('Value (%)')
pylab.show()

# line styles
for ls in ['-','--', '-.',':',]:
    print('\nLine Style: ', repr(ls))
    pylab.plot(x, y1, ls+'+', linewidth = 2) 
    pylab.xscale('log') # 'linear', 'log', 'logit', 'symlog'
    pylab.ylim(0,100)
    pylab.show()    

# marker styles
for m in ['.', ',', 'o', 'v','^', '<', '>', '1', '2', '3', '4', 's', 'p',\
              '*','h','H','+','x', 'D', 'd','|', '_']:
    print('Marker: ', repr(m))
    pylab.plot(x, y1, m)
    pylab.xscale('log') # 'linear', 'log', 'logit', 'symlog'
    pylab.ylim(0,100)
    pylab.show()
    
# line/marker color
''' color setting also support: 
    full name, ('green', 'red')
    hex string ('#008ff00')
    RGB tuple    (0, 128, 255)
    grayscale as string '128'
    '''
for col in ['b','g','r','c','m','y','k','w']:
    print('\nColor: ', repr(col))
    pylab.plot(x, y1, col + '.-', linewidth = 2) 
    pylab.xscale('log') # 'linear', 'log', 'logit', 'symlog'
    pylab.ylim(0,100)
    pylab.show()

s = []
for x in range(10000):
    s.append(random.random())
    
pylab.hist(s, bins = 10)
pylab.show()