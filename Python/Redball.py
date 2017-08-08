# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
from random import randint

b = ['R','R','R','G','G']
picklist = list()
count = 0
while count < 60000:
    left = list(b)
    p = []
    red = 0
    green = 0
    while True:
        removed = randint(0,len(left)-1)
        if left[removed] == "R":
            red += 1
        elif left[removed] == "G":
            green += 1
        p.append(left[removed])
        left.pop(removed)
        if red == 3 or green == 2:
            break;
        
    picklist.append(p)
    count += 1

#for item in picklist:
#    print(item)    
    
rrr = 0
gg = 0
other = 0
for item in picklist:
    score = 0
    red = 0
    green = 0
    for ball in item:
        if ball == "R":
            red += 1
        else:
            green += 1
    if red == 3 and green != 2:
        rrr += 1
    elif green == 2:
        gg += 1
    else:
        other += 1
        
        
Total = rrr + gg + other
print("instance with THREE RED: %d; %02.02f" % (rrr, rrr/Total))
print("instance with TWO GREEN: %d; %02.02f" % (gg, gg/Total))
print("instance with Others: %d; %02.02f" % (other, other/Total))
