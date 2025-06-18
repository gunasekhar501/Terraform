terraform {
  backend "s3" {
    bucket         = ""   ## buket name
    key            = ""   ## path to statefile
    region         = ""   ## region
    use_lockfile = true   ## S3 statelock configuration
  }
}