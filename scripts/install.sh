#!/bin/bash
#
#	Installationsscript duk-demo


# Jupyter Scripte etc. Allgemein verfuegbar machen
cp -rpv data/* /data/

##########################
# HELM (Achtung bei Versionwechsel auch client.sh aendern).
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

##########################
# Prometheus
# helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
# helm install coreos/prometheus-operator --name prometheus-operator --namespace monitoring
# helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring
# helm install --name="kube-metrics" stable/kube-state-metrics --namespace=monitoring

##########################
# Istio
curl -s -L https://git.io/getLatestIstio | ISTIO_VERSION=1.3.3 sh -
for i in istio-1.3.3/install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
kubectl apply -f istio-1.3.3/install/kubernetes/istio-demo.yaml
