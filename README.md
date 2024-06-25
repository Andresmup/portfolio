# AWS STATIC WEB HOSTING


![SCHEMA](images/aws-portfolio-light.png)

## REGISTER DOMAIN ROUTE53
In order to deploy the web in a custom domain, we first need to register (purchase) this domain. This can be dome directly in AWS Route53, the cost may vary base on the tld. Of course, the domain must be available. Let's break each step.

### Check domain availability

With this command you cancheck through the AWS CLI if the domain it's available
```.sh
aws route53domains check-domain-availability --region us-east-1 --domain-name example.com
```
### Check domain availability

If you want to register the domain you can run this command.
```sh
aws route53domains register-domain --region us-east-1 --cli-input-json file://register-domain.json
```
Make sure that the `register-domain.json` contains the following information with your data.
```json
{
    "DomainName": "example.com",
    "DurationInYears": 1,
    "AutoRenew": true,
    "AdminContact": {
        "FirstName": "Martha",
        "LastName": "Rivera",
        "ContactType": "PERSON",
        "OrganizationName": "Example",
        "AddressLine1": "1 Main Street",
        "City": "Anytown",
        "State": "WA",
        "CountryCode": "US",
        "ZipCode": "98101",
        "PhoneNumber": "+1.8005551212",
        "Email": "mrivera@example.com"
    },
    "RegistrantContact": {
        "FirstName": "Li",
        "LastName": "Juan",
        "ContactType": "PERSON",
        "OrganizationName": "Example",
        "AddressLine1": "1 Main Street",
        "City": "Anytown",
        "State": "WA",
        "CountryCode": "US",
        "ZipCode": "98101",
        "PhoneNumber": "+1.8005551212",
        "Email": "ljuan@example.com"
    },
    "TechContact": {
        "FirstName": "Mateo",
        "LastName": "Jackson",
        "ContactType": "PERSON",
        "OrganizationName": "Example",
        "AddressLine1": "1 Main Street",
        "City": "Anytown",
        "State": "WA",
        "CountryCode": "US",
        "ZipCode": "98101",
        "PhoneNumber": "+1.8005551212",
        "Email": "mjackson@example.com"
    },
    "PrivacyProtectAdminContact": true,
    "PrivacyProtectRegistrantContact": true,
    "PrivacyProtectTechContact": true
}
```
## TERRAFORM DEPLOY

In order to deploy the AWS infrastructure you need to create a file named `values.tfvars` in the `terraform/` folder.
```tfvars
#Variables for deploy
tld = "yourtld" #Example "com"
naked_domain = "your-naked-domain" #Example "example"
sub_domain = "www" 
github_org = "github-user" #Example "Andresmup"
repository_name = "repo-name" #Example "portfolio"
account_id = "your-account-id" #Example "012345678901"
protocol = "https" 
```

Once your deploy data is ready you only need to run the following commands in the `terraform/` path.

```sh
terraform init
terraform plan --out deploy
terraform apply deploy -var-file="values.tfvars"
```

