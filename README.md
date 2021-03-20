<!-- ABOUT THE PROJECT -->
## About The Project

Please, read the following medium [article](https://medium.com/codex/optimal-region-partitioning-for-uavs-and-drones-in-cooperative-flight-settings-c0764a6450f9) to learn more about the implemented partitioning algorithm.

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

[Install the Haskell Tool "Stack"](https://docs.haskellstack.org/en/stable/README/)
```sh
curl -sSL https://get.haskellstack.org/ | sh
```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/mdiamantino/optimal-region-partitioning-convex-polygons-haskell.git
   ```
2. Enter the cloned directory
   ```sh
   cd optimal-region-partitioning-convex-polygons-haskell/
   ```
3. Build the project
   ```sh
   stack build
   ```


<!-- USAGE EXAMPLES -->
## Usage
1. Run the program in ghci
   ```sh
   stack ghci
   ```
2. Using your own polygon's coordinates and number of partitions:  
  computePartitions [Point x y, Point x' y', ...] numOfPartitions
  Example:
   ```sh
   computePartitions [Point 0.0 0.0, Point 0.0 5.0, Point 7.0 7.0, Point 4.0 0.0] 3
   ```
  **Note:** coordinates must be of the Haskell type Double (float).

<!-- CONTACT -->
## Contact

Mark Diamantino Caribé - Mark.Diamantinocaribe@student.kulevuen.be - [LinkedIn](https://be.linkedin.com/in/markdiamantinocaribe)

Project Link: [https://github.com/mdiamantino/optimal-region-partitioning-convex-polygons-haskell](https://github.com/mdiamantino/optimal-region-partitioning-convex-polygons-haskell)
