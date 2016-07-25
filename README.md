# Nucleotid.es Amazon Machine Image (AMI)

These set of scripts are used the generate the amazon machine image which is
used to run the nucleotides evaluations on EC2. This image is configured with
docker-engine installed and the latest version of the [nucleotides benchmarking
client.][client]

[client]: https://github.com/nucleotides/nucleotides-client

The script `start_benchmarks.sh` fetches the nucleotides API URL and S3 URL
from the EC2 user-data and uses this to start the nucleotides cleint. This
therefore requires EC2 instances launched with this AMI to have this
information set in the user-data.

## Notes

  * If docker-engine fails to install try updating the latest version of the
    ubnutu xenial AMI. This should be hvm:ebs to take advantage of the latest
    EC2 hardware.
