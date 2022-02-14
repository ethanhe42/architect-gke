export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd ~/ak8s/Cloud_SQL
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Cloud_SQL
gcloud sql instances create sql-instance --tier=db-n1-standard-2 --region=us-central1
gcloud sql users create sqluser --instance=sql-instance --password=sqlpassword
gcloud sql users create sqluser --host=% --instance=sql-instance --password=sqlpassword
export SQL_NAME=qwiklabs-gcp-04-991ca0d5409c:us-central1:sql-instance
gcloud sql connect sql-instance

# mysql> create database wordpress;
# Query OK, 1 row affected (0.04 sec)
# mysql> use wordpress;
# Database changed
# mysql> exit;
# Bye

kubectl create secret generic sql-credentials    --from-literal=username=sqluser   --from-literal=password=sqlpassword
mv ~/qwiklabs-gcp-04-991ca0d5409c-a9fc83fbe51a.json credentials.json
kubectl create secret generic google-credentials   --from-file=key.json=credentials.json
sed -i 's/<INSTANCE_CONNECTION_NAME>/'"${SQL_NAME}"'/g'   sql-proxy.yaml
kubectl apply -f sql-proxy.yaml
gcloud sql connect sql-instance
