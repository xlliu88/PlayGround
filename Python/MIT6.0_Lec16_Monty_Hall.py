# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 15:19:10 2017

@author: xunliangliu

Monty Hall simulation
"""
import random
import pylab

def montyChoose(guess, prize):
    while True:
        mChoose = random.randint(1,3)
        if mChoose != guess and mChoose != prize:
            return mChoose
        else:
            continue

def guestChoose(mCh):
    while True:
        gCh = random.randint(1,3)
        if gCh != mCh:
            return gCh
        else:
            continue

def MontyHallSim(nTrials):
    stickwin = 0
    switchwin = 0
    stickloss = 0
    switchloss = 0
    for t in range(nTrials):
        prize = random.randint(1,3)
        guess = random.randint(1,3)
        mCh = montyChoose(guess, prize)
        gCh = guestChoose(mCh)
        if gCh == prize and gCh == guess:
            stickwin += 1
        elif gCh == prize and gCh != guess:
            switchwin += 1
        elif gCh != prize and gCh == guess:
            stickloss += 1
        elif gCh != prize and gCh != guess:
            switchloss += 1
            
    return stickwin, switchwin, stickloss, switchloss

nTrials = 1000
stickwin, switchwin, stickloss, switchloss = MontyHallSim(nTrials)
print(stickwin, switchwin, stickloss, switchloss)
pylab.pie([stickwin, switchwin, stickloss, switchloss], 
          colors = ['red', 'green', 'gray', 'yellow'], 
          labels = ['Stick', 'Switch', 'Stick Loss', 'Switch Loss'],
          autopct = '%.2f%%')
pylab.show()



