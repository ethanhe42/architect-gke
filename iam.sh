export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Security/
kubectl apply -f restricted-psp.yaml
kubectl get podsecuritypolicy restricted-psp
export USERNAME_1_EMAIL=$(gcloud info --format='value(config.account)')
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USERNAME_1_EMAIL
kubectl apply -f restricted-pods-role.yaml
kubectl get clusterrole restricted-pods-role
gcloud beta container clusters update $my_cluster --zone $my_zone --enable-pod-security-policy
kubectl get podsecuritypolicies
kubectl auth can-i use podsecuritypolicy/gce.privileged
kubectl apply -f privileged-pod.yaml
kubectl delete pod privileged-pod
gcloud container clusters update $my_cluster --zone $my_zone --start-credential-rotation
gcloud container clusters update $my_cluster --zone $my_zone --complete-credential-rotation
gcloud container operations list
export UPGRADE_ID=$(gcloud container operations list --filter="TYPE=UPGRADE_NODES and status=DONE" --format='value(NAME)')
gcloud container operations wait $UPGRADE_ID --zone=$my_zone
$UPGRADE_ID
gcloud container clusters upgrade $my_cluster --zone $my_zone --node-pool=default-pool
gcloud container clusters update $my_cluster --zone $my_zone --complete-credential-rotation
kubectl create clusterrolebinding restricted-pods-binding --clusterrole restricted-pods-role --user student-01-63ab7779f776@qwiklabs.net
kubectl apply -f unprivileged-pod.yaml
kubectl apply -f privileged-pod.yaml
kubectl create clusterrolebinding restricted-pods-binding --clusterrole restricted-pods-role --user student-01-63ab7779f776@qwiklabs.net

