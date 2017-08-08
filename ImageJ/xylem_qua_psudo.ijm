//psudo code

dir = path
roipath
barpath
rois = getFileList(roipath)
for (roi in rois){
	label = getshortfilename
	img = shortname + "tif";
	open(img)
	if (bar exist): load bar; setscale;
	else SetBar;
	load roi
	setThreshold() // get leaf disc area
	measure disc area
	
	setthreshold()
	measure UV area and UV intensity
	for (res in ress){
		UVarea = UVarea + getResult("area", i);
		inte = inte + getResult("Intensity", i);
	}
	
	arr = newArray (label; disc area; UV area; intensity;)
}
write(txt file)

setResult("Label", 0, "Image01");
IJ.renameResults("Measurements");
selectWindow("Measurements");
setResult("Area", 0, 1000);

