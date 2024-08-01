# terraform-gcp

Before running `terraform init`, set up a service account for Terraform to authenticate with GCP.

## Create a Service Account

1. In the GCP Console, navigate to `IAM & Admin > Service Accounts`.
2. Click `+ CREATE SERVICE ACCOUNT`.
3. Provide a name and description for the service account.
4. Assign the required roles (e.g., `Viewer`, `Editor`, or more specific roles depending on your needs).
5. Click `Done` to create the service account.

## Generate a Service Account Key

1. Select the newly created service account.
2. Click `Add Key > Create New Key`.
3. Choose `JSON` and click `Create`. The key file will be downloaded to your machine.

## Set the Service Account Key as an Environment Variable

Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of the downloaded key file.

## Authenticate Your Shell with the Service Account

Run the following `gcloud` command to authenticate your shell with the above service account:

```sh
gcloud auth activate-service-account sa-demo-tf-sbx@playpen-742d6a.iam.gserviceaccount.com --key-file=playpen-742d6a-54ad3e59243b.json --project=playpen-742d6a
