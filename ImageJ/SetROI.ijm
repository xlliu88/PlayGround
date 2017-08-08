function saveROI(img, type, path){
	roiManager("Add");
	roiManager("Select", 0);
	splitedname = split(img, ".");
	ext = splitedname[splitedname.length-1];
	name = "";
	for (i = 0; i<= splitedname.length-2; i+=1) {
		if (i==0) {
			name += splitedname[i];
		} else {
			name = name + '.' + splitedname[i];
		}
	}

	label = name + "." + type;
	roiManager("Rename", label);
	roiManager("Select",0);
	if (File.exists(path + label + ".roi")) {
		label = getString("File Exist! Use a new File Name", label);
	}
	saveAs("Selection", path + label + ".roi");
	roiManager("Delete");
}

function filetest(file, ch, ext){
	if (File.isDirectory(file)) return "skip";
	fnarray = split(file, "\\.");
	n = fnarray.length;
	if (n < 3) return "skip";
	if (fnarray[n-1] == ext && fnarray[n-2] == ch) return file;
	return "skip";
}

dir = getDirectory("Choose a Directory");
roipath = dir + "ROIs\\";
File.makeDirectory(roipath);
files = getFileList(dir);
for (i=0;i<files.length;i+=1) {
	f = files[i];
	test = filetest(f, "UV", "tif");
	if (test != "skip") {
		open(dir + f);
		waitForUser("Select a Region for measurement");
		saveROI(f, "ROI", roipath);
		close();
	}

}