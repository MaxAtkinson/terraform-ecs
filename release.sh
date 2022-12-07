set -e

aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 490542905848.dkr.ecr.eu-west-2.amazonaws.com

docker build -t my-first-ecr-repo .
docker tag my-first-ecr-repo:latest 490542905848.dkr.ecr.eu-west-2.amazonaws.com/my-first-ecr-repo:latest
docker push 490542905848.dkr.ecr.eu-west-2.amazonaws.com/my-first-ecr-repo:latest

terraform apply -auto-approve
