# Machine Vision Project

This project implements several image processing tasks using MATLAB, including image extraction, binarization, skeletonization, character segmentation, and classification using k-Nearest Neighbors (kNN). The final step involves hyperparameter optimization for the kNN model.

## Project Structure

### Folders

- **data/**: Contains the dataset used for classification.
  - `hello_world.jpg`: The original image used in the image processing tasks.
  - `p_dataset_26/`: Contains subfolders for each character ('D', 'E', 'H', 'L', 'O', 'R', 'W'), each holding images for training and testing.

- **results/**: Stores the output images generated during the image processing tasks.
  - `binary_image.png`: The binarized image.
  - `labeled_image.png`: The image with labeled segments.
  - `outline_image.png`: The outline of characters.
  - `skeleton_image.png`: The skeletonized image.
  - `sub_image.png`: A sub-image extracted from the original image.

- **src/**: Contains the utility functions used in the project.
  - `binarize_image.m`: A function that binarizes an image.
  - `find_contours.m`: A function that finds the contours of objects in a binary image.
  - `segmentAndLabelCharacters.m`: A function that segments and labels characters in the image.
  - `skeletonize.m`: A function that skeletonizes a binary image using Lee's algorithm.

### MATLAB Scripts

- **main_1_to_6.m**: Solves the first six parts of the project, including:
  1. Loading the original image.
  2. Extracting a sub-image.
  3. Binarizing the sub-image.
  4. Skeletonizing the binary image.
  5. Finding and plotting contours.
  6. Segmenting and labeling characters.

- **main_7.m**: Implements the kNN-based classification of characters. It loads data from the `p_dataset_26` folder, extracts features, partitions the dataset, trains a kNN model, and evaluates its accuracy.

- **main_8.m**: Implements hyperparameter optimization for the kNN model using the dataset.

## Usage

### Prerequisites

- MATLAB (version R2021a or later is recommended).
- Ensure that you have the Image Processing Toolbox installed.

### How to Run

1. Clone the repository or download the project files.
   
2. Navigate to the project directory and add the `src` folder to the MATLAB path:
   ```matlab
   addpath('src');
   ```

3. Run the first six tasks by executing the `main_1_to_6.m` script:
   ```matlab
   run('main_1_to_6.m');
   ```
   This will display intermediate images and save the results in the `results/` folder.

4. For character classification using kNN, run the `main_7.m` script:
   ```matlab
   run('main_7.m');
   ```
   This script will load the dataset, train the kNN model, and display the classification accuracy.

5. To optimize the kNN model's hyperparameters, run the `main_8.m` script:
   ```matlab
   run('main_8.m');
   ```

### Output

- The outputs of the image processing tasks (binarized images, skeleton images, etc.) are saved in the `results/` folder.
- The classification accuracy of the kNN model will be printed in the MATLAB console.

## Functions

The following functions are available in the `src/` folder:

- **binarize_image.m**: Converts an image to a binary (black and white) image.
- **find_contours.m**: Detects the outlines of objects in a binary image.
- **segmentAndLabelCharacters.m**: Segments and labels individual characters in a binary image.
- **skeletonize.m**: Applies Lee's skeletonization algorithm to a binary image.

## Dataset

The dataset used for character classification is stored in the `data/p_dataset_26/` folder. It consists of images of the letters 'D', 'E', 'H', 'L', 'O', 'R', and 'W'. Each folder contains images of the corresponding letter.

### Dataset Partitioning

In `main_7.m`, the dataset is partitioned such that:
- 75% of the data is used for training.
- 25% of the data is used for testing.

## kNN Classification

In `main_7.m`, a k-Nearest Neighbors (kNN) model is trained using the training data. The number of neighbors (`k`) is set to 3. The accuracy of the model is computed on the test set and printed in the console as a percentage.

## Hyperparameter Optimization

In `main_8.m`, hyperparameter optimization is performed to find the best `k` value for the kNN model.

## License

This project is for educational purposes and is part of a Machine Vision course. Please contact the course author for any licensing details.

## Author

- **Qing Ye**, National University of Singapore (NUS), College of Design and Engineering.