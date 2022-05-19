# Automate Keycloak client management with GitHub Actions and Terraform

This repository holds Keycloak client configuration files for the Ministry of Health Keycloak instance. A GitHub Actions workflow is used to apply the configurations to the Keycloak instance using Terraform Cloud.

![image](https://user-images.githubusercontent.com/1767127/169346578-be0c2c46-deb5-4ceb-879f-9710534e3eeb.png)

The workflow will:

1. check whether the configuration is formatted properly to demonstrate how you can enforce best practices
2. generate a plan for every pull requests
3. apply the configuration when you update the main branch

This repo is a companion repo to the [Automate Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions?in=terraform/automation).

![image](https://user-images.githubusercontent.com/1767127/169342125-20158f98-8094-4430-b2b3-4f3f539bd367.png)

1. **Checkout** check outs the current configuration. Uses defines the action/Docker image to run that specific step. The checkout step "uses" GitHub's actions/checkout@v2 action.
1. **Setup Terraform** retrieves the Terraform CLI used in the GitHub action workflow.
1. **Terraform Format** checks whether the configuration has been properly formatted. If the configuration isn't properly formatted this step will produce an error. It enforces Terraform best practices by preventing your team from merging misformatted configuration to main.
1. **Terraform Init** initializes the configuration used in the GitHub action workflow.
1. **Terraform Validate** validates the configuration used in the GitHub action workflow.
1. **Terraform Plan** generates a Terraform plan. Since main.tf configures the Terraform Cloud integration, this step triggers a remote plan run in the Terraform Cloud. Notice:
    * This step only runs on pull requests. The PR generates a plan. When the PR is merged, that plan will be applied.
    * This step will continue even when it errors. This allows the next step to display the plan error message even if this step fails.
1. **Update Pull Request** adds a comment to the pull request with the results of the format, init and plan steps. In addition, it displays the plan output (steps.plan.outputs.stdout). This allows your team to review the results of the plan directly in the PR instead of opening Terraform Cloud. This step only runs on pull requests.
1. **Terraform Plan Status** returns whether a plan was successfully generated or not. This step highlights whenever a plan fails because the "Terraform Plan" step continues on error.
1. **Terraform Apply** applies the configuration. This step will only run when a commit is pushed to main.

## Acknowledgements

This README uses some text verbatim and diagrams from [Terraform's documentation]([url](https://learn.hashicorp.com/tutorials/terraform/github-actions)).
