# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 09:54:06 2017

@author: xunliangliu
"""

# python std librarys

import os  # interact with operation system
import shutil  # easier for daily file/directory management.
import glob    # file wildcard
import sys     
import getopt # command line argument parse. use UNIX conventions.
import argparse # command line argument parse, more powerful
import re       # regular expression support


os.open() # don't import os as *; otherwise os.open() will override built-in open()
os.listdir() # list all files and subdirectories in current directory
os.walk('.') # recursively list files/subdirectories

shutil.move('sourcefile.py', '/target/dir/targetfile.py')
shutil.copyfile('file.py', 'newfile.py') # rename if in the same directory

glob.glob('*.py') # will list all .py file in current directory

sys.exit() # to terminate a script
sys.argv   # get the command line arguments as a list; first one is py file itself
# sys.argv can be analyzed by getopt module or argparse module
sys.stderr.write('warnings') # warning output

re.findall(pattern, 'string')
re.sub(pattern, sub, 'string')

# math related modules
import random
import math
import statistics

random.choice(['a','b','c']) # pick one
random.sample(range(10),3)   # pick 3 from a list
random.random() # generate a random float (0,1]
random.randint()

math.cos()
math.sin()
math.log()
math.sqrt()

statistics.mean() # argument is a list of int/float
statistics.median() # argument is a list of int/float
statistics.variance() # argument is a list of int/float
