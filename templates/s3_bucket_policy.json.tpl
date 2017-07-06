{
  "Version": "2012-10-17",
  "Id": "S3PolicyId1",
  "Statement": [
    {
      "Sid": "AllowFromFastly",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${bucket_name}/*",
      "Condition": {
         "IpAddress": {
           "aws:SourceIp": [
            ${fastly_cidrs},
            ${office_cidrs}
           ]
         }
      }
    }
  ]
}
