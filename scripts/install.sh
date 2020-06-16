#!/bin/bash
#
#   Installationsscript duk-demo


# Jupyter Scripte etc. Allgemein verfuegbar machen
cp -rpv data/* /data/

##########################
# Package Manager (HELM - Achtung bei Versionwechsel auch client.sh aendern).
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

##########################
# Monitoring (Prometheus)
kubectl create namespace monitoring
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install prometheus-operator stable/prometheus-operator --namespace=monitoring

##########################
# ServiceMesh (Istio)
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.2 sh -
sudo cp istio-1.6.2/bin/istioctl /usr/local/bin/
istioctl install -y --set profile=demo

##########################
# Serverless (Knative) - Installation erfolgt in Juypter
# kubectl apply --filename https://github.com/knative/serving/releases/download/v0.15.0/serving-crds.yaml
# kubectl apply --filename https://github.com/knative/serving/releases/download/v0.15.0/serving-core.yaml

# kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.15.0/release.yaml
wget https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 -O kn
chmod 755 kn
sudo mv kn /usr/local/bin/

##########################
# Lasttests (hey)
wget https://storage.googleapis.com/hey-release/hey_linux_amd64 -O hey
chmod 755 hey
sudo mv hey /usr/local/bin/
