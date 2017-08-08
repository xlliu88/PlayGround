# -*- coding: utf-8 -*-
"""
Created on Sun Feb  5 12:58:15 2017

@author: xunliangliu
"""
from random import *  # in this manner, you can use the function directly.
                      # can use this statment to avoid name conflict. 
                      # it could be problemtic due to introducing unknow names
from random import Random()
import random as rnd
import builtins # dir() won't display builtin functions and variables; 
dir(builtins)   # to show builtin functions and variables, import builtins module and use dir()

import json
json.dumps(dd)