// write to tables
label = "File";
title1 = "Table"; 
title2 = "["+title1+"]"; //add [] makes it a table handler
f1=title2; 
f2="[bars]";
run("New... ", "name="+f1+" type=Table"); 
run("New... ", "name="+f2+" type=Table");
x = 100;
y = 150;
z = 300;
print(f1, "\\Headings:Label\tX\tY\tZ");
print(f2, "\\Headings:Label\tX\tY\tZ");
for (e = 1; e<=10; e+=1){
	lb = label + " " + e;
	x = x + e*10;
	y = y + e*50;
	z = z + e*30;
	print(f1, lb + "\t" + x + "\t" + y + "\t" + z);
	print(f2, lb + "\t" + x + "\t" + y + "\t" + z);
}

//write to a file
f = File.open(""); // display file open dialog
//f = File.open(path + filename);
// use d2s() function (double to string) to specify decimal places 
print(f, "X\tY\tZ");
for (i=0; i<=2*PI; i+=0.1)
  print(f, d2s(i,6) + "  \t" + d2s(sin(i),6) + " \t" + d2s(cos(i),6));

