//PREPROCESADO
run("Duplicate...", "title=Original");
run("Median...", "radius=2");
run("Subtract Background...", "rolling=20");
run("Gaussian Blur...", "sigma=0.8");
run("Unsharp Mask...", "radius=1.2 mask=0.6");


//eliminar las zonas brillantes que no son PNN a mano antes de hacer el threshold
setAutoThreshold("Otsu dark no-reset");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Erode");
run("Dilate");
roiManager("Reset");
run("Analyze Particles...", "size=100-Infinity pixel  add");
run("Set Measurements...", "area mean median redirect=None decimal=3");






