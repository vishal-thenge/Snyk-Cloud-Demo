# Snyk-Cloud-Demo

## Deployment

Add the following Github Variables:

```
SNYK_ORG
SNYK_TOKEN
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```


## Cleanup

To delete the environment from Snyk Cloud use the UI or the following command:

```
curl -X DELETE \
  'https://api.snyk.io/rest/orgs/YOUR-ORGANIZATION-ID/cloud/environments/YOUR-ENVIRONMENT-ID?version=2022-12-21~beta' \
  -H 'Authorization: token YOUR-SERVICE-ACCOUNT-TOKEN'
```

