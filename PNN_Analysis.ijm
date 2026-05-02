// ------------------------------------------------
// PNN (Perineuronal Nets) Image Analysis Pipeline
// ------------------------------------------------

// PRE-PROCESSING
run("Duplicate...", "title=Original"); // Creates a copy to preserve raw data for intensity measurements
run("Median...", "radius=2");          // Reduces salt-and-pepper noise while preserving PNN boundary integrity
run("Subtract Background...", "rolling=20"); // Removes non-specific background fluorescence using a rolling ball algorithm
run("Gaussian Blur...", "sigma=0.8");   // Applies light smoothing to homogenize signal before edge enhancement
run("Unsharp Mask...", "radius=1.2 mask=0.6"); // Sharpens the mesh-like structure of the nets to improve segmentation

// MANUAL STEP REMINDER
// Note: Use the 'Eraser' or 'Clear' tool to manually remove bright artifacts that are not PNNs before proceeding to thresholding.

// SEGMENTATION AND FILTERING
setAutoThreshold("Otsu dark no-reset"); 
setOption("BlackBackground", true);
run("Convert to Mask"); 
run("Erode");  // Morphological erosion to separate overlapping or clustered nets
run("Dilate"); // Morphological dilation to restore objects to their approximate original size
roiManager("Reset");

// QUANTIFICATION SETUP
// Configures measurements; 'Median' is included to account for the heterogeneous intensity of PNNs
run("Set Measurements...", "area mean median redirect=None decimal=3");

// PARTICLE ANALYSIS
// Identifies objects based on size (min 100 px) to exclude small debris and records them in the ROI Manager
run("Analyze Particles...", "size=100-Infinity pixel add");

