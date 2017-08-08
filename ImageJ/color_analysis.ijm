OriIma = getTitle();
selectWindow(OriIma);
x = getWidth();
y = getHeight();
//newImage("duplicate", "RGB", x, y, 1)

for (px = 0; px <= x; px += 1){
	for (py=0;py <= y; py += 1){
		color = getPixel(px,py);
		if (bitDepth==24){
			red = (color>>16)&0xff;
			green = (color>>8)&0xff;
			blue = color&0xff;
			ca = newArray(red, green, blue);
			//print(ca);
			Array.getStatistics(ca, min, max, mean, std);
			print(std);
			if (std > 50){
				setColor(255,0,0);
				setLineWidth(1);
				drawLine(px,py,px,py);
			}
		}
		
	}
}

