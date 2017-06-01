This repository will create and manage your delivery connect role settings.

1. Install `terraform` - https://www.terraform.io/intro/getting-started/install.html
2. Download and unzip a copy of this repository - https://github.com/BIAINC/tf_delivery_connect/archive/master.zip
3. Run `terraform plan`
  - You will be prompted for you AWS access key and AWS secret access key
  - The result is a list of changes that will be made to your aws account.
  Example:
  ```
  Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_iam_policy.policy
    arn:         "<computed>"
    description: "TotalDiscovery Delivery Connect Policy"
    name:        "totaldiscovery_delivery_connect"
    path:        "/"
    policy:      "{\n    \"Version\": \"2012-10-17\",\n    \"Statement\": [\n        {\n            \"Sid\": \"BucketCreation\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:CreateBucket\"\n            ],\n            \"Condition\": {\n                \"StringLike\": {\n                    \"s3:x-amz-acl\": \"bucket-owner-full-control\"\n                }\n            },\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ]\n        },\n        {\n            \"Sid\": \"BucketNotifications\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:PutBucketNotification\",\n                \"s3:GetBucketNotification\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ]\n        },\n        {\n            \"Sid\": \"BucketUploads\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:PutObject\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*/*\"\n            ],\n            \"Condition\": {\n                \"StringLike\": {\n                    \"s3:x-amz-acl\": \"bucket-owner-full-control\",\n                    \"s3:x-amz-server-side-encryption\": \"AES256\"\n                }\n            }\n        },\n        {\n            \"Sid\": \"BucketListing\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:ListBucket\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ],\n            \"Condition\": {}\n        },\n        {\n            \"Sid\": \"ShowBuckets\",\n            \"Effect\": \"Allow\",\n            \"Action\": \"s3:ListAllMyBuckets\",\n            \"Resource\": \"*\",\n            \"Condition\": {}\n        }\n    ]\n}\n"

+ aws_iam_policy_attachment.test-attach
    name:             "totaldiscovery_delivery_connect"
    policy_arn:       "${aws_iam_policy.policy.arn}"
    roles.#:          "1"
    roles.1548516742: "totaldiscovery_delivery_connect"

+ aws_iam_role.role
    arn:                "<computed>"
    assume_role_policy: "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"AWS\": \"arn:aws:iam::832478607820:root\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"
    create_date:        "<computed>"
    name:               "totaldiscovery_delivery_connect"
    path:               "/"
    unique_id:          "<computed>"
```
3. Run `terraform apply`
  - You will be prompted for you AWS access key and AWS secret access key
  - This command will update or create the needed aws resoruces and will provide the role ARN to be sent to the TotalDiscovery team.
  Example:

  ```
  aws_iam_role.role: Creating...
  arn:                "" => "<computed>"
  assume_role_policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"AWS\": \"arn:aws:iam::832478607820:root\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"
  create_date:        "" => "<computed>"
  name:               "" => "totaldiscovery_delivery_connect"
  path:               "" => "/"
  unique_id:          "" => "<computed>"
aws_iam_policy.policy: Creating...
  arn:         "" => "<computed>"
  description: "" => "TotalDiscovery Delivery Connect Policy"
  name:        "" => "totaldiscovery_delivery_connect"
  path:        "" => "/"
  policy:      "" => "{\n    \"Version\": \"2012-10-17\",\n    \"Statement\": [\n        {\n            \"Sid\": \"BucketCreation\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:CreateBucket\"\n            ],\n            \"Condition\": {\n                \"StringLike\": {\n                    \"s3:x-amz-acl\": \"bucket-owner-full-control\"\n                }\n            },\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ]\n        },\n        {\n            \"Sid\": \"BucketNotifications\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:PutBucketNotification\",\n                \"s3:GetBucketNotification\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ]\n        },\n        {\n            \"Sid\": \"BucketUploads\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:PutObject\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*/*\"\n            ],\n            \"Condition\": {\n                \"StringLike\": {\n                    \"s3:x-amz-acl\": \"bucket-owner-full-control\",\n                    \"s3:x-amz-server-side-encryption\": \"AES256\"\n                }\n            }\n        },\n        {\n            \"Sid\": \"BucketListing\",\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:ListBucket\"\n            ],\n            \"Resource\": [\n                \"arn:aws:s3:::delivery-*\"\n            ],\n            \"Condition\": {}\n        },\n        {\n            \"Sid\": \"ShowBuckets\",\n            \"Effect\": \"Allow\",\n            \"Action\": \"s3:ListAllMyBuckets\",\n            \"Resource\": \"*\",\n            \"Condition\": {}\n        }\n    ]\n}\n"
aws_iam_policy.policy: Creation complete (ID: arn:aws:iam::832478607820:policy/totaldiscovery_delivery_connect)
aws_iam_role.role: Creation complete (ID: totaldiscovery_delivery_connect)
aws_iam_policy_attachment.test-attach: Creating...
  name:             "" => "totaldiscovery_delivery_connect"
  policy_arn:       "" => "arn:aws:iam::832478607820:policy/totaldiscovery_delivery_connect"
  roles.#:          "" => "1"
  roles.1548516742: "" => "totaldiscovery_delivery_connect"
aws_iam_policy_attachment.test-attach: Creation complete (ID: totaldiscovery_delivery_connect)

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path:

Outputs:

delivery_role_arn = arn:aws:iam::832478607820:role/totaldiscovery_delivery_connect
```

5. Provide the delivery_role_arn (see the last line of the output of `tf apply`)
