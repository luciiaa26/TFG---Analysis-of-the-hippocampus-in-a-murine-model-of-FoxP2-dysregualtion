setAutoThreshold("MaxEntropy dark no-reset");
//setThreshold(255, 255);
run("Convert to Mask");
run("Erode");
run("Dilate");
run("Analyze Particles...", "size=200-Infinity pixel circularity=0.25-1.00 display exclude add");
run("Set Measurements...", "area mean min perimeter median redirect=None decimal=3");
