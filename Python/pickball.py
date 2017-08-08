# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
from random import randint
import math

print(2**31)
a = {"Name":"XL", "Age":33}
hash("Name")
bin(hash('Name'))
k1 = bin(hash("Name"))
k2 = bin(hash("Age"))
print(k1)
print(k2)
print(a)


b = ['R','R','R','G','G']
picklist = list()
count = 0
while count < 10000:
    p = []
    left = list(b)
    i = 0
    while i < 3:
        removed = randint(0,len(left)-1)
        p.append(left[removed])
        left.pop(removed)
        i += 1
        
    picklist.append(p)
#    print("===== Round %d =====" % count)
#    print("picklist", picklist)
#    print()
    count += 1

    
    
RRR = 0
RRG = 0
RGG = 0
for item in picklist:
    score = 0
    for ball in item:
        if ball == "R":
            score += 1
        else:
            score += 0
    if score == 3:
        RRR += 1
    elif score == 2:
        RRG += 1
    elif score == 1:
        RGG += 1
        
Total = RRR + RRG + RGG
print(Total)    
print("instance with THREE RED: %d; %02.02f" % (RRR, RRR/Total))
print("instance with TWO RED: %d; %02.02f" % (RRG, RRG/Total))
print("instance with ONE RED: %d; %02.02f" % (RGG, RGG/Total))
