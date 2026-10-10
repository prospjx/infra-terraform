module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source                     = "./modules/s3"
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  s3_bucket_id                   = module.s3.bucket_id
  s3_bucket_arn                  = module.s3.bucket_arn
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  backend_domain_name            = "a1613cb55e3bd41878fb3deeca6e5d23-400166061.us-east-1.elb.amazonaws.com"
}



module "dynamodb" {
  source = "./modules/dynamodb"
}

module "eks" {
  source = "./modules/eks"

  subnet_ids = module.vpc.subnet_ids
}

module "node_group" {
  source       = "./modules/node_group"
  cluster_name = module.eks.cluster_name
  subnet_ids   = module.vpc.subnet_ids
}
