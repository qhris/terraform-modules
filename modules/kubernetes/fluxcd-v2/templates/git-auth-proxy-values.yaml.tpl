priorityClassName: "platform-medium"
networkPolicy:
  enabled: true
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    memory: 256Mi
config: |
  {
    "organizations": [
      {
        "provider": "azuredevops",
        "azuredevops": {
          "pat": "${azure_devops_pat}"
         },
        "host": "dev.azure.com",
        "name": "${azure_devops_org}",
        "repositories": [
          %{ for tenant in tenants ~}
          {
            "project": "${tenant.project}",
            "name": "${tenant.repo}",
            "namespaces": ["${tenant.namespace}"],
            "secretNameOverride": "flux"
          },
          %{ endfor }
          {
            "project": "${azure_devops_proj}",
            "name": "${cluster_repo}",
            "namespaces": ["flux-system"],
            "secretNameOverride": "flux-system"

        "provider": "github",
        "github": {
          "appID": ${app_id},
          "installationID": ${installation_id},
          "privateKey": "${private_key}"
        },
        "host": "github.com",
        "name": "${github_org}",
        "repositories": [
          %{ for tenant in tenants ~}
          {
            "name": "${tenant.repo}",
            "namespaces": ["${tenant.namespace}"],
            "secretNameOverride": "flux"
          },
          %{ endfor }
          {
            "name": "${cluster_repo}",
            "namespaces": ["flux-system"],
            "secretNameOverride": "flux-system"
          }
        ]
      }
    ]
  }
