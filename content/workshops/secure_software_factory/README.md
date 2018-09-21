# Must have existing OpenShift Environment
You can use either of the OpenShift provsioners from RedHatGov
 - https://github.com/RedHatGov/redhatgov.workshops/tree/master/openshift-aws-setup
 - https://github.com/RedHatGov/redhatgov.workshops/tree/master/openshift_terraform
 - https://github.com/gnunn1/openshift-aws-setup
 - https://github.com/jaredhocutt/openshift-provision
 - https://github.com/bit4man/ansible_agnostic_deployer

# Environment Setup
If you'd like to setup an individual environment, use the commands below to set it up or delete the single environment.

## Help

$ scripts/provision.sh --help

### Individual Environment

$ scripts/provision.sh deploy --deploy-che --ephemeral

### Individual Delete

$ scripts/provision.sh delete

# Batch Setup
If you'd like to setup the workshop for numerous users, go into the provision-batch-setup.sh script and update for loop with the amount of users .  This will create an isolated environment per user.

To run the script

$ ./provision-batch-setup.sh

# Batch Delete
If you'd like to delete, run the script for the users you'd like to delete by updating the for loop

To run the script

$ ./provision-batch-delete.sh
