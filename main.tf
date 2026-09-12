module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "eks" {
  source = "./modules/eks"

  subnet_ids = module.vpc.subnet_ids
}
