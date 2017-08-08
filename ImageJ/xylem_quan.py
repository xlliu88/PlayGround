from ij import IJ
import os

path = IJ.getDir("Choose a Directory")
c = 0
for f in os.listdir(path):
	try:
		ext = f.split('.')[-1]
		ch = f.split('.')[-2]
	except:
		continue
	if ext == 'tif' and ch == 'UV':
		print f, " is a UV channel"
		img = IJ.open(''.join([path, f]))
		#IJ.setAutoThreshold(img, "Default dark")
		IJ.run("8-bit")
		IJ.setThreshold(255,255)
		IJ.run("Close")
		c += 1
		if c >= 5:
			break
	
	

	