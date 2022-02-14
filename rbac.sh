export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/RBAC/
kubectl create -f ./my-namespace.yaml
kubectl apply -f ./my-pod.yaml --namespace=production
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user student-04-1f6546545890@qwiklabs.net
kubectl apply -f pod-reader-role.yaml
export USER2=student-02-8cf5e013fa78@qwiklabs.net
sed -i "s/\[USERNAME_2_EMAIL\]/${USER2}/" username2-editor-binding.yaml
kubectl apply -f username2-editor-binding.yaml



export my_zone=us-central1-a
export my_cluster=standard-cluster-1
source <(kubectl completion bash)
gcloud container clusters get-credentials $my_cluster --zone $my_zone
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Security/
cd ~/ak8s/RBAC/
kubectl apply -f ./production-pod.yaml
history -w /dev/stdout
