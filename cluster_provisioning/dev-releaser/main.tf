provider "aws" {
  shared_credentials_file = var.shared_credentials_file
  region                  = var.region
  profile                 = var.profile
}

module "common" {
  source = "../modules/common"

  hysds_release                         = var.hysds_release
  opera_pcm_repo                        = var.opera_pcm_repo
  opera_pcm_branch                      = var.opera_pcm_branch
  product_delivery_repo                 = var.product_delivery_repo
  product_delivery_branch               = var.product_delivery_branch
  pcm_commons_repo                      = var.pcm_commons_repo
  pcm_commons_branch                    = var.pcm_commons_branch
  bach_api_repo                         = var.bach_api_repo
  bach_api_branch                       = var.bach_api_branch
  bach_ui_repo                          = var.bach_ui_repo
  bach_ui_branch                        = var.bach_ui_branch
  opera_bach_api_repo                   = var.opera_bach_api_repo
  opera_bach_api_branch                 = var.opera_bach_api_branch
  opera_bach_ui_repo                    = var.opera_bach_ui_repo
  opera_bach_ui_branch                  = var.opera_bach_ui_branch
  venue                                 = var.venue
  counter                               = var.counter
  private_key_file                      = var.private_key_file
  git_auth_key                          = var.git_auth_key
  jenkins_api_user                      = var.jenkins_api_user
  keypair_name                          = var.keypair_name
  jenkins_api_key                       = var.jenkins_api_key
  ops_password                          = var.ops_password
  shared_credentials_file               = var.shared_credentials_file
  profile                               = var.profile
  project                               = var.project
  region                                = var.region
  az                                    = var.az
  subnet_id                             = var.subnet_id
  verdi_security_group_id               = var.verdi_security_group_id
  cluster_security_group_id             = var.cluster_security_group_id
  pcm_cluster_role                      = var.pcm_cluster_role
  pcm_verdi_role                        = var.pcm_verdi_role
  mozart                                = var.mozart
  metrics                               = var.metrics
  grq                                   = var.grq
  factotum                              = var.factotum
  ci                                    = var.ci
  common_ci                             = var.common_ci
  autoscale                             = var.autoscale
  lambda_vpc                            = var.lambda_vpc
  lambda_role_arn                       = var.lambda_role_arn
  lambda_job_type                       = var.lambda_job_type
  lambda_job_queue                      = var.lambda_job_queue
  cnm_r_handler_job_type                = var.cnm_r_handler_job_type
  cnm_r_job_queue                       = var.cnm_r_job_queue
  cnm_r_event_trigger                   = var.cnm_r_event_trigger
  cnm_r_allowed_account                 = var.cnm_r_allowed_account
  daac_delivery_proxy                   = var.daac_delivery_proxy
  daac_endpoint_url                     = var.daac_endpoint_url
  asg_use_role                          = var.asg_use_role
  asg_role                              = var.asg_role
  asg_vpc                               = var.asg_vpc
  aws_account_id                        = var.aws_account_id
  lambda_package_release                = var.lambda_package_release
  environment                           = var.environment
  use_artifactory                       = var.use_artifactory
  artifactory_base_url                  = var.artifactory_base_url
  artifactory_repo                      = var.artifactory_repo
  artifactory_mirror_url                = var.artifactory_mirror_url
  grq_aws_es                            = var.grq_aws_es
  grq_aws_es_host                       = var.grq_aws_es_host
  grq_aws_es_port                       = var.grq_aws_es_port
  grq_aws_es_host_private_verdi         = var.grq_aws_es_host_private_verdi
  use_grq_aws_es_private_verdi          = var.use_grq_aws_es_private_verdi
  use_daac_cnm                          = var.use_daac_cnm
  crid                                  = var.crid
  cluster_type                          = var.cluster_type
  l0a_timer_trigger_frequency           = var.l0a_timer_trigger_frequency
  l0b_timer_trigger_frequency           = var.l0b_timer_trigger_frequency
  rslc_timer_trigger_frequency          = var.rslc_timer_trigger_frequency
  network_pair_timer_trigger_frequency  = var.network_pair_timer_trigger_frequency
  l0b_urgent_response_timer_trigger_frequency = var.l0b_urgent_response_timer_trigger_frequency
  obs_acct_report_timer_trigger_frequency = var.obs_acct_report_timer_trigger_frequency
  rs_fwd_bucket_ingested_expiration     = var.rs_fwd_bucket_ingested_expiration
  dataset_bucket                        = var.dataset_bucket
  code_bucket                           = var.code_bucket
  lts_bucket                            = var.lts_bucket
  triage_bucket                         = var.triage_bucket
  isl_bucket                            = var.isl_bucket
  osl_bucket                            = var.osl_bucket
  use_s3_uri_structure                  = var.use_s3_uri_structure
  inactivity_threshold                  = var.inactivity_threshold
}

locals {
  default_source_event_arn = "arn:aws:${var.cnm_r_event_trigger}:${var.region}:${var.aws_account_id}:${var.cnm_r_event_trigger == "kinesis" ? "stream/" : ""}${var.project}-${var.venue}-${module.common.counter}-daac-cnm-response"
  daac_proxy_cnm_r_arn     = "arn:aws:sns:${var.region}:${var.aws_account_id}:${var.project}-${var.venue}-${module.common.counter}-daac-proxy-cnm-response"
  source_event_arn         = local.default_source_event_arn
  artifactory_user         = var.artifactory_user
  artifactory_api          = var.artifactory_api_key
  lambda_repo              = "${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/lambda"
  crid                     = lower(var.crid)
}

resource "null_resource" "mozart" {
  depends_on = [module.common]

  triggers = {
    private_ip       = module.common.mozart.private_ip
    private_key_file = var.private_key_file
    code_bucket      = module.common.code_bucket
    dataset_bucket   = module.common.dataset_bucket
    triage_bucket    = module.common.triage_bucket
    lts_bucket       = module.common.lts_bucket
    osl_bucket       = module.common.osl_bucket
  }

  connection {
    type        = "ssh"
    host        = self.triggers.private_ip
    user        = "hysdsops"
    private_key = file(self.triggers.private_key_file)
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "source ~/.bash_profile",
      "~/mozart/ops/opera-pcm/cluster_provisioning/run_smoke_test.sh \\",
      "  ${var.project} \\",
      "  ${var.environment} \\",
      "  ${var.venue} \\",
      "  ${module.common.counter} \\",
      "  ${var.use_artifactory} \\",
      "  ${var.artifactory_base_url} \\",
      "  ${var.artifactory_repo} \\",
      "  ${var.artifactory_mirror_url} \\",
      "  ${var.opera_pcm_repo} \\",
      "  ${var.opera_pcm_branch} \\",
      "  ${var.product_delivery_repo} \\",
      "  ${var.product_delivery_branch} \\",
      "  ${var.delete_old_cop_catalog} \\",
      "  ${var.delete_old_tiurdrop_catalog} \\",
      "  ${var.delete_old_rost_catalog} \\",
      "  ${var.delete_old_pass_catalog} \\",
      "  ${var.delete_old_observation_catalog} \\",
      "  ${var.delete_old_track_frame_catalog} \\",
      "  ${var.delete_old_radar_mode_catalog} \\",
      "  ${module.common.mozart.private_ip} \\",
      "  ${module.common.isl_bucket} \\",
      "  ${local.source_event_arn} \\",
      "  ${var.daac_delivery_proxy} \\",
      "  ${var.use_daac_cnm} \\",
      "  ${local.crid} \\",
      "  ${var.cluster_type} \\",
      "  \"${var.l0a_timer_trigger_frequency}\" \\",
      "  \"${var.l0b_timer_trigger_frequency}\" \\",
      "  \"${var.l0b_urgent_response_timer_trigger_frequency}\" \\",
      "  \"${var.obs_acct_report_timer_trigger_frequency}\" \\",
      "  \"${var.rslc_timer_trigger_frequency}\" \\",
      "  \"${var.network_pair_timer_trigger_frequency}\" || :"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "source ~/.bash_profile",
      "~/mozart/ops/opera-pcm/conf/sds/files/test/dump_job_status.py http://127.0.0.1:8888",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "source ~/.bash_profile",
      "cat /tmp/datasets.txt",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/datasets.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "cat /tmp/check_stamped_dataset_result.txt",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/check_stamped_dataset_result.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "cat /tmp/cop_catalog.txt",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/cop_catalog.txt)",
      "cat /tmp/tiurdrop_catalog.txt",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/tiurdrop_catalog.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "cat /tmp/rost_catalog.txt",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/rost_catalog.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/radar_mode_catalog.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/check_empty_isl_result.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/check_expected_force_submits.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      "SUCCESS=$(grep -c ^SUCCESS /tmp/report_datasets.txt)",
      "if [[ \"$${SUCCESS}\" -eq 0 ]]; then exit 1; fi",
      # publish opera-pcm and CNM_product_delivery source tarballs and HySDS packages to artifactory
      "cd /data",
      "pwd",
      "aws s3 ls",
      "aws s3 ls --recursive ${module.common.code_bucket}",
      "sds pkg export container-iems-sds_opera-pcm:${var.opera_pcm_branch}",
      "ls -l",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T container-iems-sds_opera-pcm-${var.opera_pcm_branch}.sdspkg.tar -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/hysds_pkgs/container-iems-sds_opera-pcm-${var.opera_pcm_branch}.sdspkg.tar\"",
      "rm -rf container-iems-sds_opera-pcm-${var.opera_pcm_branch}.sdspkg.tar",
      "sds pkg export container-iems-sds_cnm_product_delivery:${var.product_delivery_branch}",
      "ls -l",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o opera-pcm-${var.opera_pcm_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/opera-pcm/archive/${var.opera_pcm_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T opera-pcm-${var.opera_pcm_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/opera-pcm-${var.opera_pcm_branch}.tar.gz\"",
      "rm -rf opera-pcm-${var.opera_pcm_branch}.tar.gz",
      "ls -l",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T container-iems-sds_cnm_product_delivery-${var.product_delivery_branch}.sdspkg.tar -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/hysds_pkgs/container-iems-sds_cnm_product_delivery-${var.product_delivery_branch}.sdspkg.tar\"",
      "rm -rf container-iems-sds_cnm_product_delivery-${var.product_delivery_branch}.sdspkg.tar",
      "ls -l",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o CNM_product_delivery-${var.product_delivery_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/CNM_product_delivery/archive/${var.product_delivery_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T CNM_product_delivery-${var.product_delivery_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/CNM_product_delivery-${var.product_delivery_branch}.tar.gz\"",
      "rm -rf CNM_product_delivery-${var.product_delivery_branch}.tar.gz",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o pcm_commons-${var.pcm_commons_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/pcm_commons/archive/${var.pcm_commons_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T pcm_commons-${var.pcm_commons_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/pcm_commons-${var.pcm_commons_branch}.tar.gz\"",
      "rm -rf pcm_commons-${var.pcm_commons_branch}.tar.gz",
      # Bach components
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o bach-api-${var.bach_api_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/bach-api/archive/${var.bach_api_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T bach-api-${var.bach_api_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/bach-api-${var.bach_api_branch}.tar.gz\"",
      "rm -rf bach-api-${var.bach_api_branch}.tar.gz",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o bach-ui-${var.bach_ui_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/bach-ui/archive/${var.bach_ui_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T bach-ui-${var.bach_ui_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/bach-ui-${var.bach_ui_branch}.tar.gz\"",
      "rm -rf bach-ui-${var.bach_ui_branch}.tar.gz",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o opera-bach-api-${var.opera_bach_api_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/opera-bach-api/archive/${var.opera_bach_api_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T opera-bach-api-${var.opera_bach_api_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/opera-bach-api-${var.opera_bach_api_branch}.tar.gz\"",
      "rm -rf opera-bach-api-${var.opera_bach_api_branch}.tar.gz",
      "curl -L -H \"Authorization: token ${var.git_auth_key}\" -o opera-bach-ui-${var.opera_bach_ui_branch}.tar.gz \"https://github.jpl.nasa.gov/IEMS-SDS/opera-bach-ui/archive/${var.opera_bach_ui_branch}.tar.gz\"",
      "curl -v -u ${var.artifactory_user}:${var.artifactory_api_key} -T opera-bach-ui-${var.opera_bach_ui_branch}.tar.gz -X PUT \"${var.artifactory_base_url}/${var.artifactory_repo}/gov/nasa/jpl/opera/sds/pcm/opera-bach-ui-${var.opera_bach_ui_branch}.tar.gz\"",
      "rm -rf opera-bach-ui-${var.opera_bach_ui_branch}.tar.gz",
      # publish opera-pcm and CNM_product_delivery docker images to artifactory's docker registry
      "ssh -o StrictHostKeyChecking=no -q -i ~/.ssh/${basename(var.private_key_file)} hysdsops@${var.common_ci["private_ip"]} 'docker login -u ${var.artifactory_user} --password ${var.artifactory_api_key} cae-artifactory.jpl.nasa.gov:16001; docker tag container-iems-sds_opera-pcm:${var.opera_pcm_branch} cae-artifactory.jpl.nasa.gov:16001/gov/nasa/jpl/opera/sds/pcm/container-iems-sds_opera-pcm:${var.opera_pcm_branch}; docker push cae-artifactory.jpl.nasa.gov:16001/gov/nasa/jpl/opera/sds/pcm/container-iems-sds_opera-pcm:${var.opera_pcm_branch}'",
      "ssh -o StrictHostKeyChecking=no -q -i ~/.ssh/${basename(var.private_key_file)} hysdsops@${var.common_ci["private_ip"]} 'docker login -u ${var.artifactory_user} --password ${var.artifactory_api_key} cae-artifactory.jpl.nasa.gov:16001; docker tag container-iems-sds_cnm_product_delivery:${var.product_delivery_branch} cae-artifactory.jpl.nasa.gov:16001/gov/nasa/jpl/opera/sds/pcm/container-iems-sds_cnm_product_delivery:${var.product_delivery_branch}; docker push cae-artifactory.jpl.nasa.gov:16001/gov/nasa/jpl/opera/sds/pcm/container-iems-sds_cnm_product_delivery:${var.product_delivery_branch}'",
    ]
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "set -ex",
      "source ~/.bash_profile",
      "~/mozart/ops/opera-pcm/cluster_provisioning/purge_aws_resources.sh ${self.triggers.code_bucket} ${self.triggers.dataset_bucket} ${self.triggers.triage_bucket} ${self.triggers.lts_bucket} ${self.triggers.osl_bucket}",
    ]
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -q -i ${var.private_key_file} hysdsops@${module.common.mozart.private_ip}:/tmp/datasets.txt ."
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -q -i ${var.private_key_file} hysdsops@${module.common.mozart.private_ip}:/tmp/check_stamped_dataset_result.txt ."
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -q -i ${var.private_key_file} hysdsops@${module.common.mozart.private_ip}:/tmp/cop_catalog.txt ."
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -q -i ${var.private_key_file} hysdsops@${module.common.mozart.private_ip}:/tmp/tiurdrop_catalog.txt ."
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -q -i ${var.private_key_file} hysdsops@${module.common.mozart.private_ip}:/tmp/rost_catalog.txt ."
  }
}
