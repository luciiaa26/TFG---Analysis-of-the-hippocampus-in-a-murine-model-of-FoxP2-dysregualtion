// -----------------------------
// cFos Image Analysis Pipeline
// -----------------------------

// PRE-PROCESSING
run("Duplicate...", "title=Procesada"); // Creates a copy to preserve the original raw data
run("Median...", "radius=1"); // Replaces each pixel with the median of its neighbors to eliminate shot noise
run("Subtract Background...", "rolling=15"); // Removes uneven background illumination 
run("Gaussian Blur...", "sigma=1.5"); // Smooths edges and reduces high-frequency noise to improve thresholding consistency
run("Min...", "value=0.5"); // Removes very low-level residual noise

// OPTIONAL: VISUAL OPTIMIZATION
resetMinAndMax(); 
run("Enhance Contrast", "saturated=0.50"); // Simulates Auto Brightness and contrast adjustment

// SEGMENTATION AND FILTERING
setAutoThreshold("MaxEntropy dark no-reset");
setOption("BlackBackground", true); 
run("Convert to Mask"); 
run("Erode"); // Removes isolated pixels/thins objects to separate close-together nuclei
run("Dilate"); // Expands objects back to their original size after erosion
roiManager("Reset");
run("Set Measurements...", "area mean integrated density redirect=None decimal=3"); // Defines which metrics to calculate during analysis
run("Analyze Particles...", "size=85-infinity pixel add"); // Identifies objects >85 pixels and adds them to the ROI Manager
