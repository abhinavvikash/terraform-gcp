# terraform-gcp

Before running terraform init setup service account for terraform to authenticate with GCP

Create a Service Account:
    — In the GCP Console, navigate to `IAM & Admin > Service Accounts`.
    — Click `+ CREATE SERVICE ACCOUNT`.
    — Provide a name and description for the service account.
    — Assign the required roles (e.g., `Viewer`, `Editor`, or more specific roles depending on your needs).
    — Click `Done` to create the service account.
Generate a Service Account Key:
    — Select the newly created service account.
    — Click `Add Key > Create New Key`.
    — Choose `JSON` and click `Create`. The key file will be downloaded to your machine.
    Set the Service Account Key as an Environment Variable:
    — Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of the downloaded key file.
Run gcloud command to authenticate your shell with the above service account:
    —  example : gcloud auth activate-service-account sa-demo-tf-sbx@playpen-742d6a.iam.gserviceaccount.com                              --key-file=playpen-742d6a-54ad3e59243b.json --project=playpen-742d6a

