#!/bin/bash
#
#	Installationsscript duk-demo

##########################
# User snoopy anlegen

openssl genrsa -out snoopy.pem 2048
openssl req -new -key snoopy.pem -out snoopy.csr -subj "/CN=snoopy"

cat <<%EOF% | kubectl apply -f -
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: user-request-snoopy
spec:
  groups:
  - system:authenticated
  request: $(cat snoopy.csr | base64 | tr -d '\n')
  usages:
  - digital signature
  - key encipherment
  - client auth
%EOF%

kubectl certificate approve user-request-snoopy
kubectl get csr user-request-snoopy -o jsonpath='{.status.certificate}' | base64 -d > snoopy.crt

mkdir .kube
kubectl --kubeconfig .kube/config-snoopy config set-cluster kubernetes --insecure-skip-tls-verify=true --server=https://$(hostname -I | cut -d ' ' -f 2):6443
kubectl --kubeconfig .kube/config-snoopy config set-credentials snoopy --client-certificate=snoopy.crt --client-key=snoopy.pem --embed-certs=true

kubectl --kubeconfig .kube/config-snoopy config set-context snoopy --cluster=kubernetes --user=snoopy 
kubectl --kubeconfig .kube/config-snoopy config use-context snoopy

kubectl apply -f rbac/

kubectl describe secret $(kubectl get secret | grep snoopy | awk '{print $1}') >dashboard-snoopy.txt

##########################
# HELM (Achtung bei Versionwechsel auch client.sh aendern).
curl -L https://git.io/get_helm.sh | bash
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account=tiller --wait
helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring
helm install --name="kube-metrics" stable/kube-state-metrics --namespace=monitoring

##########################
# Istio
curl -s -L https://git.io/getLatestIstio | ISTIO_VERSION=1.3.3 sh -
for i in istio-1.3.3/install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
kubectl apply -f istio-1.3.3/install/kubernetes/istio-demo.yaml

# Bookinfo Beispielanwendung Namespace
kubectl create namespace bookinfo
kubectl label namespace bookinfo istio-injection=enabled

# Web V1 + V2 Anwendung Namespace
kubectl create namespace web
kubectl label namespace web istio-injection=enabled    
