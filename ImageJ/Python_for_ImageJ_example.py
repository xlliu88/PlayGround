from ij import IJ
import os
import math

class point():
	def __init__(self,x=0,y=0):
		self.x = 0
		self.y = 0
	def distance(self, p1, p2):
		dist = (p2.x - p1.x)**2 + (p2.y-p1.y)**2
		return math.sqrt(dist)
	def distance_from(self, p0):
		distfrom = (self.x - p0.x)**2 + (self.y - p0.y)**2
		return math.sqrt(distfrom)

position1 = point()
position2 = point()
position1.x = 2
position1.y = 5
position2.x = 45
position2.y = 30
print position1.distance_from(position2)
print position1.distance(position1, position2)
print type(position1)