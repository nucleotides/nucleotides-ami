# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 0.1.0

### Added

  * Created benchmarking script which fetches API and S3 locations from the AMI
    user data. The script uses these locations to start the benchmarking
    process.

### Fixed

  * Fixed location of nucleotides-client in the `$PATH` environment variable.

### Changed

  * Switched to the ubuntu 16.04 LTS base AMI.

  * Removed all existing ssh keys from the created AMI.
