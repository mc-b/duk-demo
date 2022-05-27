#!/bin/bash
#
#   Installationsscript duk-demo


# Jupyter Scripte etc. Allgemein verfuegbar machen
cp -rpv data/* /data/

##########################
# Monitoring (Prometheus)
microk8s kubectl create namespace monitoring
microk8s helm3 repo add stable https://charts.helm.sh/stable
microk8s helm3 install prometheus-operator stable/prometheus-operator --namespace=monitoring

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
