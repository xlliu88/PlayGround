// for xylem assay analysis
var barhandle, reshandle, flog;
var barlength, barunit;
var imgbkg;
var barpath, roipath, respath, olpath;
var disc_low, xylem_low;
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
pdate = toString(year) + "-" + toString(month+1) + "-" + toString(dayOfMonth) + " " + toString(hour) + ":" + toString(minute) + ":" + toString(second);
var pause = 500;

function init(dir){
	//make subdirectories
	barpath = dir + "bars\\";
	roipath = dir + "rois\\";
	respath = dir + "Results\\";
	olpath = dir + "Overlays\\";
	if (!File.exists(barpath)) File.makeDirectory(barpath);
	if (!File.exists(respath)) File.makeDirectory(respath);
	if (!File.exists(roipath)) File.makeDirectory(roipath);
	if (!File.exists(olpath)) File.makeDirectory(olpath);
	barlength = 0.1;
	barunit = "mm";
	imgbkg = "dark";
	disc_low = 35;
	//xylem_low = 48;
	
	//set Region of Interest for measurement
	setROI(dir);
	//setup a table to record bar informations
	bartitle = "Bar Coordinates";
	barhandle = "[" + bartitle + "]";
	run("New... ", "name=" + barhandle +" type=Table");
	print(barhandle, "\\Headings:File Name\tCoordinates(x,y)\tWidth (pix)\tHeight(pix)\tknown distance");
	//setup a table to record Measurement results
	restitle = "Measurements";
	reshandle = "[" + restitle + "]";
	run("New... ", "name=" + reshandle +" type=Table");
	print(reshandle, "\\Headings:File Name\tThreshold\tLeaf Disc Area (um)\tXylem Area (um)\tIntnsity");
	//setup a file to log processing events
	flog = File.open(respath + "log.txt");
	print(flog, "Processing Date: " + pdate);
	print(flog, "Selected Directory: \n" + dir);
}

function fileExt(filename){
	// return the extension of a file name
	s = split(filename, ".");
	if (s.length < 2) return 0;
	return s[s.length-1];
}

function shortName(filename){
	// return file name w/o extension
	s = split(filename, ".");
	if (s.length < 2) return 0;
	stname = "";
	for (i=0; i<s.length-1; i+=1){
		if (i==0) stname += stname + s[i];
		else stname = stname + "." + s[i];
	}
	return stname;
}

function fileTest(file, ch, ext){
	//to test if a file is 
	// 		1. with specific extension
	//		2. from a specific channel, eg. "UV", "GFP", "BF"
	//		3. if ch=="", will not do channel test
	if (File.isDirectory(file)) return 0;
	fnarray = split(file, "\\.");
	n = fnarray.length;
	if (ch==""){
		if(n < 2) return 0;
		if(farray[n-1] == ext) return 1;
	} else {
		if (n < 3) return 0;
		if (fnarray[n-1] == ext && fnarray[n-2] == ch) return 1;
		return 0;
	}
}

function SetBar(img, bkg, dist, unit){
	// set bar information for images
	// will first look for bars in dir\bars directory; if not find, will find bar in image and save an ROI in dir\bars directory;
	// bar info will be saved in table "bars".
	label = shortName(img);
	barfile = label + ".roi";
	if (File.exists(barpath + barfile)) {
		roiManager("open", barpath + barfile);
	} else {
		findBar(img, "dark");
		roiManager("Add");
	}
	
	par = "known=" + dist + " unit=" + unit;
	run("Set Scale...", par);
	Roi.getBounds(x,y,width,height);
	saveROI(0, barpath, shortName(img), "bar");
	print(barhandle, img + "\t" + "(" + x +"," + y + ")" + "\t" + width + "\t" + height + "\t" + dist + " (" + unit + ")");
}

function findBar(img, bkg) {
	// to find bar in an image; bar has to be horizontal
	// only works if bar is in black or in white
	// there should be no pure black/white pixels under bar
	run("8-bit");
	if (bkg == "dark"){ // if image has a dark background find bar in white pixels
		//setAutoThreshold("Default dark");
		setThreshold(255, 255);
	} else {			// else find bar in black pixels
		setThreshold(0, 0);
	}
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
	run("Set Measurements...", "bounding display redirect=None decimal=3");
	run("Analyze Particles...", "  show=Overlay display record in_situ");
	
	maxy = 0;
	rbar = 0;
	for (r = 0; r < nResults; r+=1) {
		ys = getResult("YStart", r);
		if (ys > maxy) {
			maxy = ys;
			rbar = r;
		   }
	   }
	x1 = getResult("XStart", rbar);
	wbar = getResult("Width", rbar);
	x2 = x1 + wbar;
	y = maxy;
	selectWindow(img);
	makeLine(x1,y,x2,y);
	IJ.deleteRows(0, nResults-1); // clear result window
}

function setROI(dir){
	imgs = getFileList(dir);
	for (i=0;i<imgs.length;i+=1){
		if (fileTest(imgs[i], "UV", "tif")){
			label = shortName(imgs[i]); 
			if (!File.exists(roipath + label + ".raw.roi")) {
				open(dir + imgs[i]);
				setTool("polygon");
				waitForUser("Select a Region for measurement");
				roiManager("Add");
				saveROI(0, roipath, shortName(imgs[i]), "raw");
				close();
			} else {
				print ("ROI file exist for file: " + imgs[i]);
			}
		}
	}
}

function saveROI(idx, path, name, type){
	label = name + "." + type;
	roiManager("Select",idx);
	roiManager("Rename", label);
	saveAs("Selection", path + label + ".roi");
	roiManager("Delete");
}

function measureXylem(img){
	// measure the leafArea and xylem area in selected ROI;
	label = shortName(img);
	roifile = label + ".raw.roi";
	SetBar(img, imgbkg, barlength, barunit);

	selectWindow(img);
	setThreshold(disc_low, 255);
	run("Set Measurements...", "area mean modal min bounding shape integrated area_fraction limit display redirect=None decimal=3");
	roiManager("open", roipath + roifile);
	roiManager("Select", 0);
	run("Analyze Particles...", "size=0.7-Infinity show=Outlines display clear include summarize record add");

	selectWindow("Drawing of " + img);
	run("Invert");
	rename("Leaf Disc Outline.tif");
	leafch = "[Leaf Disc Outline.tif]";
	leafarea = getLeafArea();
	saveROI(0, roipath, shortName(img), "disc"); //save leaf disc ROI
	
	selectWindow(img);
	roiManager("open", roipath + label + ".disc.roi");
	roiManager("Select",0);
	
	/*
	getHistogram(hist_vals, hist_cnts, 256);
	histrank = Array.rankPositions(hist_cnts);
	peakidx = histrank[histrank.length-1];
	peakval = hist_vals[peakidx];
	peakcnt = hist_cnts[peakidx];
	
	hist_vals2 = newArray(0);	
	for (c=0; c<hist_vals.length; c++){
		cnt = hist_cnts[c];
		val = hist_vals[c];
		print("idx: ", c, " value: ", val, " Count: ", cnt);
		if (cnt>10){
			temp = newArray(1);
			temp[0] = hist_vals[c];
			hist_vals2 = Array.concat(hist_vals2, temp);
			//if (!(cnt<10)) Array.fill(hist_vals2, hist_vals[c]);
		}
		
	}
	//Array.print(hist_vals);
	//Array.print(hist_vals2);
	Array.getStatistics(hist_vals2, min, max, mean, stdDev);
	xylem_low = peakval + 1;
	print("Max: ", max, " | Min: ", min, " | Mean: ", mean); 
	print("peak value for file ", img, " is: ", peakval, " ||WITH COUNT: ", peakcnt);
	*/
	setThreshold(xylem_low, 255);
	//setAutoThreshold();
	//run("Analyze Particles...", "size=0.0001-Infinity show=Outlines display clear exclude summarize record");
	run("Analyze Particles...", "size=0.0001-Infinity show=Outlines display clear summarize record");
	roiManager("Delete");
	selectWindow("Drawing of " + img);
	run("Invert");
	rename("Xylem areas outline.tif");
	xych = "[Xylem areas outline.tif]";
	
	xyarea = getXylemArea();
	xyint = getXylemInt();
	print(reshandle, img + "\t" + xylem_low + "\t" + leafarea + "\t" + xyarea + "\t" + xyint);
	
	mgpar = "c1=" + leafch + " c2=" + xych + " c4=" + img + " creat keep ignore"; // merge parameters
	run("Merge Channels...", mgpar);
	selectWindow("RGB");
	overlayed = label + "(" + xylem_low + ").tif";
	saveAs("tif", olpath + overlayed);
	run("Close All");
}

function getLeafArea() {
	selectWindow("Results");
	res = 0;
	for (i=0;i<nResults;i+=1) {
		area = getResult("Area", i);
		if (res < area) res = area;
	}
	return res;
}

function getXylemArea(){
	res = 0;
	for (i=0;i<nResults;i+=1){
		area = getResult("Area",i);
		res += area;
	}
	return res;
}

function getXylemInt(){
	res = 0;
	for (i=0;i<nResults;i+=1){
		rawint = getResult("RawIntDen",i);
		res += rawint;
	}
	return res;
}

function clearResults(){
	selectWindow("Results");
	IJ.deleteRows(0, nResults);
}

// main code
macro XylemDetect{
	dir = getDirectory("Choose a Directory");
	init(dir);
	//imgs = getFileList(dir);
	rois = getFileList(roipath);
	for (xylem_low = 45; xylem_low < 53; xylem_low ++){
		for (r=0; r<rois.length; r+=1){
			roi = rois[r];
			if (fileTest(roi, "raw", "roi")){
				label = shortName(shortName(roi));
				img =  label + ".tif";
				open(dir + img);
				measureXylem(img);
				//run("Close All");
			}
		}
		
		selectWindow("Bar Coordinates");
		saveAs("Text", barpath + "Bar Coordinates" + ".txt");
		//run("Close");
		//selectWindow("Measurements");
		//saveAs("Text", respath + "Measurements" + "(" + xylem_low + ").txt");
		//run("Close");
		//selectWindow("Log");
		//run("Close");
		selectWindow("Results");
		run("Close");
		selectWindow("Summary");
		run("Close");
		selectWindow("ROI Manager");
		run("Close");
		}
}

	selectWindow("Measurements");
	saveAs("Text", respath + "Measurements" + "(" + xylem_low + ").txt");