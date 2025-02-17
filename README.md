# Image Processing Techniques

## Overview

This project explores various image processing techniques, including frequency domain representation, filtering, anti-aliasing, and edge detection. The goal is to understand the effects of high-pass and low-pass filtering, aliasing, and anti-aliasing on images, as well as the use of edge detection algorithms such as Canny edge detection.

For more details and illustrations refer to the [report](Report/Report.html)

## Objectives

- Capture two images for processing.
- Apply frequency transformations and visualizations to better understand image components.
- Explore Gaussian and Derivative of Gaussian (DoG) kernels for filtering.
- Investigate anti-aliasing techniques and their effects on image quality.
- Experiment with Canny edge detection and thresholding to extract meaningful edges from images.

## Tools & Techniques

### 1. **Image Capture**  
Two images were captured, one for the high-pass (HP) filtered image and one for the low-pass (LP) filtered image. These images are used as the starting point for the following processing steps.

- **HP Image**: High-pass filtered image.
- **LP Image**: Low-pass filtered image.

### 2. **Frequency Representation**  
- The images are transformed into the frequency domain, which shows how different frequency components contribute to the image. The high-pass image (HP) primarily retains high-frequency details, while the low-pass image (LP) keeps low-frequency components.

**Visual Results**:
- Frequency domain representation for both HP and LP images is shown, illustrating how the image components are distributed across various frequency bands.

### 3. **Kernels and Filtering**  
- **Gaussian Kernel**: A smoothing kernel used to blur the image by averaging nearby pixels.
- **Derivative of Gaussian Kernel (DoG)**: A kernel used for edge detection by calculating the gradient of the image.

The project visualizes both the **Gaussian Kernel** and **DoG Kernel** to understand their effects on images. The filters are applied to the images to create the high-pass and low-pass filtered versions, followed by their frequency-domain representations.

**Visual Results**:
- Gaussian and DoG filters applied to both HP and LP images are displayed, with their frequency-domain versions showing the transformation.

### 4. **Anti-Aliasing**  
Anti-aliasing is applied to reduce jagged edges and smooth out high-frequency components in the image. The images are subsampled by half and quarter sizes, and a Gaussian filter is applied to reduce aliasing artifacts.

**Anti-Aliasing Effects**:
- In the spatial domain, anti-aliasing smooths out jagged edges, particularly for high-frequency details like the edges of objects in the image.
- The low-frequency components remain relatively unchanged, but the high-frequency components (edges) appear smoother.

**Visual Results**:
- Both anti-aliased and non-anti-aliased images are shown, illustrating the improvement in edge smoothness and overall image quality after anti-aliasing.

### 5. **Canny Edge Detection and Thresholding**  
Canny edge detection is applied to the images with different thresholds to detect edges. The thresholds control which edges are detected, with lower thresholds capturing more edges and higher thresholds focusing on stronger edges.

**Edge Detection Results**:
- **Optimal Threshold**: The best balance of edge detection, preserving accurate edge details without excessive noise.
- **Low-Low, High-Low, Low-High, and High-High Thresholds**: Different threshold combinations result in varying amounts of noise and missed edges.

**Visual Results**:
- The Canny edge detection results for both HP and LP images are shown for each threshold combination, highlighting how different settings affect the accuracy of edge detection.

### Conclusion

This project demonstrates the application of image processing techniques such as frequency representation, filtering, anti-aliasing, and edge detection. The effects of Gaussian and DoG kernels on image filtering were visualized, and anti-aliasing techniques helped reduce jagged edges and improve image quality. Canny edge detection showed the importance of choosing the right thresholds for accurate edge detection.

The results highlight how image processing techniques can be combined to enhance image quality and extract important features from images, such as edges and details.

## License
This project was made as a part of CMPT361 offered at Simon Fraser University. Some parts of this project were provided by instructor Dr. Yagiz Aksoy