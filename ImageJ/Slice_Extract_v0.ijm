// This is a ImageJ script to extract slices from imageJ stacks
// output files will be saved in "extraceted" folder, with names ended with "_Extracted.avi"
// Xunliang Liu
// xlliu88@gmail.com
// Jan 30, 2017


path = getDirectory("Choose a Directory"); // select the target folder
save_path = path + "/extracted/"
File.makeDirectory(save_path)
files = getFileList(path);                  // list all files in the target folder
suffix = "_Extracted.avi"					// extracted file suffix
for (i=0; i<files.length; i+=1) {			// loop throuth files in the target folder
	file_name = files[i];					// to get file name
	name_array = split(file_name,"\\.");		// to split file name with "."; the last one will be file extension
    file_ext = name_array[name_array.length-1];	// get file extension
    newName = "";								// to get the file name without extension
    for (j=0;j<name_array.length-1;j++) {
            newName = newName + name_array[j]; }
	if (file_ext == "avi") {						// to test if it is an "avi" file; can change to other types if needed
		open_option = "open=" + path + file_name + " use";  // to open target file; "use": use virtual stacks, will save time and memory space.
		run("AVI...", open_option);
		slice_option = "first=1 last=" + nSlices + " increment=10";	// set extract option; change increment value as needed
		run("Slice Keeper", slice_option);
		run("AVI... ", "compression=JPEG frame=1 save=" + save_path + newName + suffix);	// save extracted stack
		run("Close All");
	}
}