# Snyk-Cloud-Demo

## Deployment

Going to put instructions here

## Cleanup

To delete the environment from Snyk Cloud, use the following command:

```
curl -X DELETE \
  'https://api.snyk.io/rest/orgs/YOUR-ORGANIZATION-ID/cloud/environments/YOUR-ENVIRONMENT-ID?version=2022-12-21~beta' \
  -H 'Authorization: token YOUR-SERVICE-ACCOUNT-TOKEN'
```

