# vi-music-infrastructure
Infra for ViMusic App

How to setup infra:
1) **Run** --- Provision - Init - Shared Backend (run ones) [Creating storage account for store shared state]
2) **Run** --- Provision - Shared [Creating shared infra like Container registry, Container for state in storage account]
3) **Run** --- Provision - DEV [Create all resources for environment]
   3.1)  TO ASSIGN ROLES FOR KEY_VAULT/APP_CONFIG, NEEDS THAT TERRAFORM APP REGISTRATION CONTAINS OWNER ROLE (NOT CONTRIBUTOR) !!!
   3.2)  TO ASSIGN ROLES FOR SHARED_CONTAINER_REGISTRY, NEEDS THAT TERRAFORM APP REGISTRATION CONTAINS OWNER ROLE (NOT CONTRIBUTOR) !!!
   
