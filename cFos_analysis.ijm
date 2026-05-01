//PREPROCESADO
run("Duplicate...", "title=Procesada");
run("Median...", "radius=1"); // Elimina ruido puntual (shot noise)
run("Subtract Background...", "rolling=15"); // Radio mayor para no perder el centro del núcleo
run("Gaussian Blur...", "sigma=1.5"); // Suaviza para un umbralizado más limpio
run("Min...", "value=0.5"); // Elimina píxeles con valores ínfimos de ruido


setAutoThreshold("MaxEntropy dark no-reset");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Erode");
run("Dilate");
roiManager("Reset");
run("Analyze Particles...", "size=85-infinity pixel  add");
run("Set Measurements...", " area mean integrated density redirect=None decimal=3");
