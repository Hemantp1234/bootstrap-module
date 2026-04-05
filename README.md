AWS + GitHub Automation (Ready-Made Module)
This project sets up a professional AWS backend for Terraform and connects it to GitHub Actions in 90 minutes.

🛠️ How to use this Module (Step-by-Step)

Step 1: Run Terraform locally
First, run these commands on your computer. This creates the "Hardware" (S3 and DynamoDB) inside your AWS account.

Bash
terraform init
terraform apply
Step 2: Create the backend.tf file
Now that your S3 bucket and DynamoDB table exist in AWS, create a new file named backend.tf in your folder. Paste the actual names of your bucket and table inside it.

Step 3: Handover your State (Local to Remote)
Run the init command again. This moves the "Memory" of your infrastructure from your MacBook to the AWS Cloud.

Bash
terraform init
When it asks to copy the state, type yes.

Step 4: Connect to GitHub Actions

Copy the ROLE_ARN from your terminal output.

Go to your GitHub Repo > Settings > Secrets.

Add a new secret named AWS_ROLE_ARN and paste the value.

🛡️ What this saves you:

☁️ S3 Bucket: Stores your code's "memory" so you can work from anywhere.

🔒 DynamoDB: Locks your code so two people can't break the infrastructure at the same time.

🤝 OIDC Handshake: No more passwords! GitHub talks to AWS using a secure, temporary key.

🔄 S3 Versioning: If you make a mistake, you can "Undo" it by going back to a previous version of the state.
