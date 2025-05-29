# LocalstackSetup
Shared setup for localstack development

## Usage Assumptions

- This repository is intended to be added as a submodule under the `submodules/` directory of your main project.
- Your main repository should have a `do.sh` script in its root. This script is expected to set variables such as `PROJECT_NAME`, `PROJECT_DIR`, and `TERRAFORM_DIR` before sourcing or invoking scripts from this submodule (see `do-localstack.sh` for details).
- The scripts in this repo are designed to be sourced or called from your main repo's scripts, allowing you to manage Localstack containers and related infrastructure alongside your own services.
- **Assumption:** The arrays `upFiles`, `downFiles`, `nukeFiles`, and `nukeSharedFiles` are initialized in your main script before sourcing `do-localstack.sh`. This allows the Localstack docker-compose file to be automatically added to these arrays.
