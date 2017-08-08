newImage("color","RGB",2560, 160,1)
r = 0;
g = 0;
b = 0;
x = 0;
y = 0;
for (r = 0; r<=255;r+=16) {
	for (g = 0; g<= 255; g+=16) {
		for (b = 0;b<=255;b+=16) {
			col = "#" + toHex(r) + toHex(g) + toHex(b);
			//x = (r/5)+(g/5)+(b/5);
			x += 10;
			if (x >= 2560){
				x=0;
				y+=10;
				}
			setColor(r,g,b);
			setLineWidth(10);
			drawLine(x,y,x,y+10);
			}
		}
	}
Dialog.create("done");
Dialog.show();
