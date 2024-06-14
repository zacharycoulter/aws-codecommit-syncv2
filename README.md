---
### UPDATE: RESOLVE UNSAFE GIT ISSUE FROM ORIGIN REPO!! 
---
# Sync up to AWS CodeCommit Action

Synchronize from GitHub repository to AWS CodeCommit via GitHub Actions.  
No need to ssh-private-key. Need to AWS IAM Credentials only.

## Example usage

```yaml
name: sync up to codecommit

on:
  push:
    branches:
      - 'dev'

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.TEST_AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.TEST_AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Sync up to CodeCommit
        uses: hectorcoy/aws-codecommit-syncv2@1.0.19
        with:
          repository_name: test_repo
          aws_region: ap-northeast-2
          branch: dev
```

## Inputs

- `repository_name` **Required** CodeCommit repository name.
- `aws_region` **Required** Region of the CodeCommit repository.
- `branch` **Required** branch

## License

[MIT](LICENSE)

