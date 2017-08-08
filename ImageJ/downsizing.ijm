// to resize images
// Jan 16, 2017
// Xunliang Liu
// xlliu88@gmail.com


path = getDirectory("Choose a Directory"); //select the target folder
list = getFileList(path);                  //list all files in the target folder
newpath = path + "resized\\"

for (i=0; i<list.length; i+=1) {
	filename = File.getName(path + list[i]);

	if (File.isDirectory(path + list[i])) {
		print(list[i] + "is a directory");
	}
	else {
		open(filename);
		h = getHeight();
		w = getWidth();
		run("Size...", "width=2400 height=1845 constrain average interpolation=Bilinear");
		saveAs("Tiff", newpath + filename);
		close();
	}
}
