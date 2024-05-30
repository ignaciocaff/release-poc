# Terraform Standard Modules

This directory contains company wide [terraform
modules](https://developer.hashicorp.com/terraform/language/modules) supported
by the Infrastructure Automation team.

## Using a module

### Finding the right version

Modules are versioned using git tags. To find the latest version of your module,
find the tags.

```bash
$ git tag | grep rds-database
rds-database-v0.1.0
rds-database-v0.2.0
```

### Upgrading a module

At some point you may be required to upgrade your module. This could be for
feature, security, compliance or just general maintenance reasons. 

Upgrading in most cases consists of the following steps:

* Update th tag in the `ref=` part of the source parameter and updating any
  module parameters that may have changed.
* Run plan to validate the change can be applied.
* Create a new PR to see the changes that need to be made by the system. Make
  sure no stateful resources need to be recreated.
* Merge the PR to make the planned changes.


### Deleting a module

Since Terraform keeps track of all state, deleting the module will in general
delete all resources contained withing it. There are exceptions to this however:

* Stateful resources such as databases and S3 buckets may have delete protection
  preventing the system from simply deleting the reosurce. See the module README
  for information on how to handle this case.
* Resources such as Secrets may have recovery periods where deleting is not
  immediate.
