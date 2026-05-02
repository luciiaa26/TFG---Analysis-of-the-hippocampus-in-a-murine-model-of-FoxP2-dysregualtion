// ------------------------------------------
// PV (Parvalbumin) Image Analysis Pipeline
// ------------------------------------------

// PRE-PROCESSING
run("Duplicate...", "title=Original"); // Creates a copy for intensity measurements
run("Median...", "radius=2");          // Reduces salt-and-pepper noise while preserving cell boundaries
run("Subtract Background...", "rolling=20"); // Removes non-specific background fluorescence
run("Gaussian Blur...", "sigma=1"); // A conservative Sigma keeps cell edges sharp
run("Unsharp Mask...", "radius=1.5 mask=0.6"); // Enhances soma contrast against the background

// AUTOMATIC SEGMENTATION
setAutoThreshold("Moments dark no-reset");
setOption("BlackBackground", true);
run("Convert to Mask");

// MORPHOLOGICAL OPENING
// The combination of multiple Erodes followed by Dilates targets and eliminates thin lines (fibers)
run("Erode"); run("Erode"); run("Dilate"); run("Dilate"); 
roiManager("Reset");

// QUANTIFICATION SETUP
run("Set Measurements...", "area mean median redirect=None decimal=3");

// PARTICLE ANALYSIS
// 1. Circularity 0.50-1.00: Filters out elongated fibers and accepts ovoid cell bodies
// 2. Size 80-Infinity: Excludes small fragments and broken fibers
run("Analyze Particles...", "size=80-Infinity circularity=0.50-1.00 show=Nothing add");