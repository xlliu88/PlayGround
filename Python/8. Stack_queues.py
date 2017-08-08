# -*- coding: utf-8 -*-
"""
Created on Sun Feb  5 11:12:05 2017

@author: xunliangliu
"""

from collections import deque
 
# use list as stack
stack = list(range(10))
stack.append(20)  # add item at the top of a stack
stack.pop() # retrive and remove item at the top of a stack

# use deque for queues
q = deque(list(range(10)))
q.append(20)
q.popleft()  # return 0, the first item of q
q.popleft()  # return 1, the first item of updated q
q.pop()      # return 9, the top item of q