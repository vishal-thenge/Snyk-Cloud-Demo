# Snyk-Cloud-Demo

This is a vulnerable by design repository for demonstrating Snyk Cloud. Do not deploy this in production

## Deployment

Add the following Github Variables:

```
SNYK_ORG
SNYK_TOKEN
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

Ensure you update these two variables:
```

#Owner CHANGE THIS
variable "victim_company" {
  type        = string
  description = "For naming purposes"
  default     = "mikedemo"
}

#Owner CHANGE THIS
variable "owner" {
  type        = string
  description = "For Tagging and Filtering purposes"
  default     = "Patch"
}
```

To deploy, just commit and push a change in the <b>_build_flag</b> file. This will kick off the Github Action.

## Cleanup

To delete the environment from Snyk Cloud use the UI or the following command:

```
curl -X DELETE \
  'https://api.snyk.io/rest/orgs/YOUR-ORGANIZATION-ID/cloud/environments/YOUR-ENVIRONMENT-ID?version=2022-12-21~beta' \
  -H 'Authorization: token YOUR-SERVICE-ACCOUNT-TOKEN'
```

