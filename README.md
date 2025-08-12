*🚀 DubeDrop
Static Website Hosting on AWS S3 with Terraform

DubeDrop is a hands-on cloud infrastructure project that uses Terraform to provision and manage AWS resources. It demonstrates core principles of Infrastructure as Code (IaC) and walks through deploying a static website on Amazon S3 — including real-world troubleshooting and AWS Console interactions.

*🧠 Real-World Analogy
Imagine you want to put up a poster in a public space. Instead of manually printing and taping it up, you write instructions once — and every time you want to post something new, the system does it for you automatically.

That’s Terraform: You write infrastructure instructions once, and it builds your cloud environment reliably and repeatably.

*📚 Table of Contents
Real-World Analogy

Project Goals

Tech Stack

Folder Structure

How It Works

Terraform Setup

Common Errors & Fixes

AWS Console Steps

Deployment Output

Testing

Cleanup Instructions

Final Notes

*🎯 Project Goals
✅ Create an S3 bucket using Terraform

✅ Upload notes.txt and index.html to the bucket

✅ Enable static website hosting

✅ Make the site publicly accessible

✅ Learn Terraform basics through real deployment

✅ Document every step and error for future reference

*🛠️ Tech Stack
Service	Purpose
AWS S3	Hosts the static website
Terraform	Provisions infrastructure as code
GitHub	Stores and version-controls the code
AWS Console	Used for manual fixes and inspection


*📁 Folder Structure
DubeDrop/
├── main.tf           # Terraform configuration
├── index.html        # Static website homepage
├── notes.txt         # Sample file uploaded to S3
├── README.md         # Project documentation
└── src/              # (Unused folder from earlier setup)


*⚙️ How It Works
Terraform provisions an S3 bucket named dube-drop-notes-2025.

It enables static website hosting and sets index.html as the homepage.

It uploads notes.txt and index.html to the bucket.

A bucket policy allows public access to all files.

The website is accessible via a public endpoint.

*🧾 Terraform Setup
✅ Commands Used

cd ~/Desktop/DubeDrop
terraform init
terraform apply

⚠️ Important: Terraform must be run from the folder containing main.tf. Running it from src/ caused errors like:

Terraform initialized in an empty directory!

🐞 Common Errors & Fixes
❌ Error: Duplicate Resource Name

Error: Duplicate resource "aws_s3_bucket_object" configuration


Fix: Renamed one of the aws_s3_bucket_object blocks to avoid duplicate names:


resource "aws_s3_bucket_object" "notes_upload" { ... }
resource "aws_s3_bucket_object" "index_upload" { ... }


❌ Error: Blocked Public Access

AccessDenied: Public policies are blocked by the BlockPublicPolicy setting.

Fix:

Went to AWS Console → S3 → Bucket → Permissions

Edited Block Public Access settings

Unchecked all four boxes

Saved changes


❌ Error: ACLs Not Supported

AccessControlListNotSupported: The bucket does not allow ACLs

Fix:

Went to AWS Console → S3 → Bucket → Permissions

Edited Object Ownership

Changed to ACLs enabled

Saved changes


❌ Error: File Downloads Instead of Rendering
Issue: Visiting the site downloaded index.html instead of displaying it.

Fix:

Re-uploaded index.html using AWS CLI with correct content type:


aws s3 cp index.html s3://dube-drop-notes-2025/index.html \
  --acl public-read \
  --content-type "text/html"

Verified no Content-Disposition: attachment metadata using:

aws s3api head-object --bucket dube-drop-notes-2025 --key index.html

*🖥️ AWS Console Steps
Enabled static website hosting

Set index.html as the index document

Edited bucket policy to allow public access

Verified website endpoint under Properties → Static Website Hosting


*📤 Deployment Output
✅ S3 Bucket: dube-drop-notes-2025 ✅ Website Endpoint: http://dube-drop-notes-2025.s3-website-us-east-1.amazonaws.com

🧪 Testing
✅ In Browser Visit the endpoint — the site loads instantly.

✅ With curl

curl http://dube-drop-notes-2025.s3-website-us-east-1.amazonaws.com

*🧹 Cleanup Instructions

To avoid charges:

🪣 S3 Bucket: Go to S3 → Select bucket → Empty → Delete

🧾 Terraform: Run terraform destroy to remove all resources




