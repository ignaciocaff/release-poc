# this should tigger eks addons PR and future tag taking care of the current version in the manifest (0.7.12)
# small change
variable "tags" {
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "environment of the kafka clusters"
  type        = string
  validation {
    condition     = can(regex("^(beta|gamma|production)$", var.environment))
    error_message = "Environment must be beta/gamma/production."
  }
}

variable "team_name" {
  description = "The owning team for these addons"
  type        = string
}

variable "admin_namespace" {
  description = "The administrator namespace to launch joint addons into"
  type        = string
  default     = "kube-system"
}

variable "cluster_name" {
  description = "The name of the EKS cluster name"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The name of the EKS OIDC issuer url"
  type        = string
}

variable "account_id" {
  description = "The account ID that the cluster is deployed into"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID of the main eks cluster VPC"
  type        = string
}

variable "aws_lb_controller_status" {
  description = "status of the aws lb controller"
  type        = string
  default     = null
}

variable "domain_hostname" {
  description = "The second-level and top-level domain separated by a period. Defaults to 'compass.com', to be used in the cluster hostname <subdomain>.eks.<domain_hostname>"
  type        = string
  default     = "compass.com"
}

###################
# Datadog
####################

variable "enable_datadog" {
  description = "enable datadog addon"
  type        = bool
  default     = true
}

variable "datadog_environment" {
  description = "datadog environment for datadog metrics"
  type        = string
  default     = ""
}

variable "datadog_secret_name" {
  description = "The name of the secret in Secrets Manager containing the DataDog API and App keys"
  default     = "compass.datadog"
}

###################
# KIAM
####################

variable "enable_kiam" {
  description = "enable kiam addon"
  type        = bool
  default     = false
}

variable "kiam_master_role_name" {
  description = "the role for kiam role name"
  type        = string
}

variable "kiam_master_role_arn" {
  description = "the role for kiam role arn"
  type        = string
}

###################
# Goldilocks
####################

variable "enable_goldilocks" {
  description = "enable goldilocks addon"
  type        = bool
  default     = false
}

variable "enable_goldilocks_ingress" {
  description = "enable goldilocks addon"
  type        = bool
  default     = false
}

###################
# Kyverno
####################

variable "enable_kyverno" {
  description = "enable kyverno addon"
  type        = bool
  default     = true
}

variable "enable_hpa" {
  description = "enable default HPA via kyverno policy. Note that this requires enable_kyverno to be true."
  type        = bool
  default     = false
}

variable "enable_pod_disruption" {
  description = "enable pod disruption budget"
  type        = bool
  default     = false
}


###################
# Loki
####################

variable "enable_loki" {
  description = "enable loki addon"
  type        = bool
  default     = false
}

###################
# Metrics Server
####################

variable "enable_metrics_server" {
  description = "enable metrics server addon"
  type        = bool
  default     = true
}

###################
# Prometheus + Thanos
####################

variable "enable_prometheus" {
  description = "enable prometheus addon"
  type        = bool
  default     = false
}


###################
# Vertical Pod Autoscaler
####################

variable "enable_vpa" {
  description = "enable vertical pod autoscaler addon"
  type        = bool
  default     = false
}

variable "enable_vpa_updater" {
  description = "whether or not to enable the VPA updates"
  type        = bool
  default     = false
}

###################
# Horizontal Pod Autoscaler
####################
variable "hpa_target_average_utilization" {
  description = "The Kubernetes HPA averageUtilization automatically scales pods based on their average CPU or memory usage percentage"
  type        = number
  default     = 80
}

variable "hpa_max_replicas" {
  description = "The HPA max replicas for each policy"
  type        = number
  default     = 3
}

variable "hpa_min_replicas" {
  description = "The HPA minimum replica count for each policy"
  type        = number
  default     = 1
}

###################
# Node Local DNS
####################

variable "enable_node_local_dns" {
  description = "enable Node local DNS addon"
  type        = bool
  default     = false
}

###################
# Istio
####################

variable "enable_istio" {
  description = "enable istio addon"
  type        = bool
  default     = false
}

variable "istio_gateway_taint_key" {
  description = "Taint key to add to the istio ingress gateway pods to make sure it's scheduled on the istio nodegroup nodes."
  type        = string
  default     = "node_group"
}

variable "istio_gateway_taint_value" {
  description = "Taint value to add to the istio ingress gateway pods to make sure it's scheduled on the istio nodegroup nodes."
  type        = string
  default     = "istio"
}

variable "istio_ingress_security_group" {
  description = "Security group to add to the Istio ingress gateway which allows access to the EKS worker nodes from the gateway."
  type        = string
  default     = "unknown"
}

variable "istio_lb_scheme" {
  description = "Determines whether the Gateway Load Balancer is internet-facing or internal. Valid options are 'internet-facing' or 'external'."
  type        = string
  default     = "internal"

  validation {
    condition     = contains(["internal", "internet-facing"], var.istio_lb_scheme)
    error_message = "The istio load balancer scheme must be either internal or internet-facing."
  }
}

variable "istio_lb_type" {
  description = "Determines whether the Gateway Load Balancer is Network Load Balancer or Application Load Balancer. Valid options are 'nlb' or 'alb'."
  type        = string
  default     = "nlb"

  validation {
    condition     = contains(["nlb", "alb"], var.istio_lb_type)
    error_message = "The istio load balancer type must be either nlb or alb."
  }
}

variable "istiod_replica_count" {
  description = "Number of replicas for istiod"
  type        = number
  default     = 2
}

###################
# Nginx Ingress
####################

variable "enable_nginx" {
  description = "enable nginx ingress controller addon"
  type        = bool
  default     = false
}

variable "nginx_replicas" {
  description = "number of nginx ingress controller pods desired"
  type        = number
  default     = 3
}

variable "enable_frontend_nginx_cti" {
  description = "enables CTI support for frontend applications"
  type        = bool
  default     = false
}

variable "enable_backend_nginx_cti" {
  description = "enables CTI support for backend/gRPC applications exposed over APIv3"
  type        = bool
  default     = false
}

variable "eks_hosted_zone" {
  description = "The hosted zone information for the new cluster"
  type        = any
}

variable "node_security_group_id" {
  description = "The security group of the node to attach ingress rules to"
  type        = string
}

variable "nginx_security_group_id" {
  description = "Security group to add to the nginx ingress gateway which allows access to the EKS worker nodes from the gateway."
  type        = string
  default     = "unknown"
}

###################
# SDIO Addons
####################

variable "enable_zookeeper" {
  description = "enable zookeeper addon"
  type        = bool
  default     = false
}

variable "enable_grafana" {
  description = "enable grafana addon"
  type        = bool
  default     = false
}


variable "enable_thanos" {
  description = "enable thanos addon"
  type        = bool
  default     = false
}

###################
# Node Termination Handler
####################

variable "enable_aws_node_termination_handler" {
  description = "enable aws node termination handler addon"
  type        = bool
  default     = false
}

variable "node_termination_handler_asg_groups" {
  description = "list of autoscaling group names"
  type        = any
  default     = []
}

####################
# K8s Usage Report
####################
variable "enable_k8s_usage_report" {
  description = "enable k8s usage report"
  type        = bool
  default     = false
}
variable "s3_k8s_usage_report_bucket_name_override" {
  description = <<EOT
    Override the name of the S3 bucket where the report csv file will be uploaded.

    By default, the expected bucket name is compass-{environment}-k8s-usage-report
  EOT
  type        = string
  default     = ""
}

####################
# Redis
####################
variable "enable_redis" {
  description = "enable redis"
  type        = bool
  default     = false
}
