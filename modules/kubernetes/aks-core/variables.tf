variable "location_short" {
  description = "The Azure region short name."
  type        = string
}

variable "environment" {
  description = "The environment name to use for the deploy"
  type        = string
}

variable "name" {
  description = "The commonName to use for the deploy"
  type        = string
}

variable "aks_name_suffix" {
  description = "The suffix for the aks clusters"
  type        = number
}

variable "aad_groups" {
  description = "Configuration for aad groups"
  type = object({
    view = map(any)
    edit = map(any)
    cluster_admin = object({
      id   = string
      name = string
    })
    cluster_view = object({
      id   = string
      name = string
    })
    aks_managed_identity = object({
      id   = string
      name = string
    })
  })
}

variable "namespaces" {
  description = "The namespaces that should be created in Kubernetes."
  type = list(
    object({
      name   = string
      labels = map(string)
      flux = object({
        enabled     = bool
        create_crds = bool
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> make fmt & docs
=======
>>>>>>> a69675f... make fmt & docs
=======
>>>>>>> f8311b7... make fmt & docs
=======
>>>>>>> make fmt & docs
=======
>>>>>>> make fmt & docs
=======
>>>>>>> Fix code
        type        = string # azuredevops or github
        org         = string
        proj        = string # only used for azuredevops
        repo        = string
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> 115a386... Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> dfd9823... Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> Initial change of config to use one module - fluxcd-v2
        type = string # azuredevops or github
        org = string
        proj = string # only used for azuredevops
        repo = string
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> make fmt & docs
=======
>>>>>>> 115a386... Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> a69675f... make fmt & docs
=======
>>>>>>> dfd9823... Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> f8311b7... make fmt & docs
=======
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> make fmt & docs
=======
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> make fmt & docs
=======
>>>>>>> Fix code
      })
    })
  )

  # add validation for type and flux parameters
}

variable "kubernetes_network_policy_default_deny" {
  description = "If network policies should by default deny cross namespace traffic"
  type        = bool
  default     = false
}

variable "kubernetes_default_limit_range" {
  description = "Default limit range for tenant namespaces"
  type = object({
    default_request = object({
      cpu    = string
      memory = string
    })
    default = object({
      memory = string
    })
  })
  default = {
    default_request = {
      cpu    = "50m"
      memory = "32Mi"
    }
    default = {
      memory = "256Mi"
    }
  }
}

variable "fluxcd_v1_enabled" {
  description = "Should fluxcd-v1 be enabled"
  type        = bool
  default     = false
}

variable "fluxcd_v1_config" {
  description = "Configuration for fluxcd-v1"
  type = object({
    flux_status_enabled = bool
    branch              = string
    azure_devops = object({
      pat  = string
      org  = string
      proj = string
    })
  })
  default = {
    flux_status_enabled = false
    branch              = "main"
    azure_devops = {
      pat  = ""
      org  = ""
      proj = ""
    }
  }
}

variable "fluxcd_v2_enabled" {
  description = "Should fluxcd-v2 be enabled"
  type        = bool
  default     = true
}

<<<<<<< HEAD
variable "fluxcd_v2_config" {
  description = "Configuration for fluxcd-v2"

  # Credentials to be passed to Git Auth Proxy
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    type = string # azuredevops or github
    azure_devops = object({
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      org = string
      pat = string
=======
      org  = string
      pat  = string
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
      org = string
      pat = string
>>>>>>> make fmt & docs
=======
      org  = string
      pat  = string
>>>>>>> 115a386... Initial change of config to use one module - fluxcd-v2
=======
      org = string
      pat = string
>>>>>>> a69675f... make fmt & docs
=======
      org  = string
      pat  = string
>>>>>>> dfd9823... Initial change of config to use one module - fluxcd-v2
=======
      org = string
      pat = string
>>>>>>> f8311b7... make fmt & docs
=======
=======
>>>>>>> Fix code
  credentials = list(object({
    type = string # azuredevops or github
    azure_devops = object({
<<<<<<< HEAD
      org  = string
      pat  = string
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
      org = string
      pat = string
<<<<<<< HEAD
>>>>>>> make fmt & docs
=======
  credentials = list(object({
    type = string # azuredevops or github
    azure_devops = object({
<<<<<<< HEAD
      org  = string
      pat  = string
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
      org = string
      pat = string
>>>>>>> make fmt & docs
=======
>>>>>>> Fix code
=======
variable "fluxcd_v2_credentials" {
  description = "List of credentials for Git Providers."
  type = list(object({
    type = string # azuredevops or github
    azure_devops = object({
      azure_devops_org  = string
      azure_devops_pat  = string
      azure_devops_proj = string
>>>>>>> mend
    })
    github = object({
      github_org             = string
      github_app_id          = number
      github_installation_id = number
      github_private_key     = string
    })
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

  # Flux Bootstrap Repository
    type = string # azuredevops or github
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    org  = string
=======
    org = string
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
    org  = string
>>>>>>> make fmt & docs
=======
    org = string
>>>>>>> 115a386... Initial change of config to use one module - fluxcd-v2
=======
    org  = string
>>>>>>> a69675f... make fmt & docs
=======
    org = string
>>>>>>> dfd9823... Initial change of config to use one module - fluxcd-v2
=======
    org  = string
>>>>>>> f8311b7... make fmt & docs
    proj = string
    repo = string
=======
=======
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> Fix code
  }))
}

<<<<<<< HEAD
  # Flux Bootstrap Repository
  fleet_infra = object({
    type = string # azuredevops or github
<<<<<<< HEAD
<<<<<<< HEAD
=======
variable "fluxcd_v2_fleet_infra" {
  description = "Configuration for Flux bootstrap repository."
  type = object({
    type = string
>>>>>>> mend
    org  = string
=======
    org = string
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
    org  = string
>>>>>>> make fmt & docs
    proj = string
    repo = string
  })
<<<<<<< HEAD
>>>>>>> Initial change of config to use one module - fluxcd-v2
=======
>>>>>>> Fix code
}

variable "aad_pod_identity_enabled" {
  description = "Should aad-pod-identity be enabled"
  type        = bool
  default     = true
}

variable "aad_pod_identity_config" {
  description = "Configuration for aad pod identity"
  type = map(object({
    id        = string
    client_id = string
  }))
}

variable "opa_gatekeeper_enabled" {
  description = "Should OPA Gatekeeper be enabled"
  type        = bool
  default     = true
}

variable "opa_gatekeeper_config" {
  description = "Configuration for OPA Gatekeeper"
  type = object({
    additional_excluded_namespaces = list(string)
    enable_default_constraints     = bool
    additional_constraints = list(object({
      excluded_namespaces = list(string)
      processes           = list(string)
    }))
    enable_default_assigns = bool
    additional_assigns = list(object({
      name = string
    }))
  })
  default = {
    additional_excluded_namespaces = []
    enable_default_constraints     = true
    additional_constraints         = []
    enable_default_assigns         = true
    additional_assigns             = []
  }
}

variable "cert_manager_enabled" {
  description = "Should Cert Manager be enabled"
  type        = bool
  default     = true
}

variable "cert_manager_config" {
  description = "Cert Manager configuration"
  type = object({
    notification_email = string
    dns_zone           = string
  })
}

variable "ingress_nginx_enabled" {
  description = "Should Ingress NGINX be enabled"
  type        = bool
  default     = true
}

variable "ingress_config" {
  description = "Ingress configuration"
  type = object({
    http_snippet              = string
    public_private_enabled    = bool
    allow_snippet_annotations = bool
  })
  default = {
    http_snippet              = ""
    public_private_enabled    = false
    allow_snippet_annotations = false
  }
}

variable "external_dns_enabled" {
  description = "Should External DNS be enabled"
  type        = bool
  default     = true
}

variable "external_dns_config" {
  description = "External DNS configuration"
  type = object({
    client_id   = string
    resource_id = string
  })
}

variable "velero_enabled" {
  description = "Should Velero be enabled"
  type        = bool
  default     = false
}

variable "velero_config" {
  description = "Velero configuration"
  type = object({
    azure_storage_account_name      = string
    azure_storage_account_container = string
    identity = object({
      client_id   = string
      resource_id = string
    })
  })
}

variable "csi_secrets_store_provider_azure_enabled" {
  description = "Should csi-secrets-store-provider-azure be enabled"
  type        = bool
  default     = true
}

variable "datadog_enabled" {
  description = "Should Datadog be enabled"
  type        = bool
  default     = false
}

variable "datadog_config" {
  description = "Datadog configuration"
  type = object({
    datadog_site     = string
    api_key          = string
    app_key          = string
    extra_namespaces = list(string)
  })
  default = {
    datadog_site     = ""
    api_key          = ""
    app_key          = ""
    extra_namespaces = [""]
  }
}

variable "grafana_agent_enabled" {
  description = "Should Grafana-Agent be enabled"
  type        = bool
  default     = false
}

variable "grafana_agent_config" {
  description = "The Grafan-Agent configuration"
  sensitive   = true
  type = object({
    remote_write_urls = object({
      metrics = string
      logs    = string
      traces  = string
    })
    credentials = object({
      metrics_username = string
      metrics_password = string
      logs_username    = string
      logs_password    = string
      traces_username  = string
      traces_password  = string
    })
  })
  default = {
    remote_write_urls = {
      metrics = ""
      logs    = ""
      traces  = ""
    }
    credentials = {
      metrics_username = ""
      metrics_password = ""
      logs_username    = ""
      logs_password    = ""
      traces_username  = ""
      traces_password  = ""
    }
  }
}

variable "falco_enabled" {
  description = "Should Falco be enabled"
  type        = bool
  default     = true
}

variable "reloader_enabled" {
  description = "Should Reloader be enabled"
  type        = bool
  default     = true
}

variable "azad_kube_proxy_enabled" {
  description = "Should azad-kube-proxy be enabled"
  type        = bool
  default     = false
}

variable "azad_kube_proxy_config" {
  description = "The azad-kube-proxy configuration"
  type = object({
    fqdn                  = string
    azure_ad_group_prefix = string
    allowed_ips           = list(string)
    azure_ad_app = object({
      client_id     = string
      client_secret = string
      tenant_id     = string
    })
  })
  default = {
    fqdn                  = ""
    azure_ad_group_prefix = ""
    allowed_ips           = []
    azure_ad_app = {
      client_id     = ""
      client_secret = ""
      tenant_id     = ""
    }
  }
}

variable "prometheus_enabled" {
  description = "Should prometheus be enabled"
  type        = bool
  default     = true
}

variable "prometheus_config" {
  description = "Configuration for prometheus"
  type = object({
    azure_key_vault_name = string
    identity = object({
      client_id   = string
      resource_id = string
      tenant_id   = string
    })

    tenant_id = string

    remote_write_authenticated = bool
    remote_write_url           = string

    volume_claim_storage_class_name = string
    volume_claim_size               = string

    resource_selector  = list(string)
    namespace_selector = list(string)
  })
}

variable "ingress_healthz_enabled" {
  description = "Should ingress-healthz be enabled"
  type        = bool
  default     = true
}

variable "linkerd_enabled" {
  description = "Should linkerd be enabled"
  type        = bool
  default     = false
}

variable "starboard_enabled" {
  description = "Should Starboard be enabled"
  type        = bool
  default     = true
}

variable "new_relic_enabled" {
  description = "Should New Relic be enabled"
  type        = bool
  default     = false
}

variable "new_relic_config" {
  description = "Configuration for New Relic"
  type = object({
    license_key = string
  })
  default = {
    license_key = ""
  }
}

variable "azure_metrics_enabled" {
  description = "Should AZ Metrics be enabled"
  type        = bool
  default     = true
}

variable "vpa_enabled" {
  description = "Should VPA be enabled"
  type        = bool
  default     = true
}

variable "azure_metrics_config" {
  description = "AZ Metrics configuration"
  type = object({
    client_id   = string
    resource_id = string
  })
}

variable "node_local_dns_enabled" {
  description = "Should VPA be enabled"
  type        = bool
<<<<<<< HEAD
  default     = true
}
=======
  default     = false
}
<<<<<<< HEAD
>>>>>>> Fix code
=======
>>>>>>> mend
