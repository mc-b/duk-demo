# Demo zum Kurs: [Docker und Kubernetes – Übersicht und Einsatz ](https://www.digicomp.ch/trends/docker-trainings/docker-und-kubernetes-uebersicht-und-einsatz)

### Quick Start

Installiert [Git/Bash](https://git-scm.com/downloads), [Vagrant](https://www.vagrantup.com/) und [VirtualBox](https://www.virtualbox.org/).

Projekt [lernkube](https://github.com/mc-b/lernkube), auf der Git/Bash Kommandozeile (CLI), klonen, Konfigurationsdatei (.yaml) kopieren und Installation starten. 

    git clone https://github.com/mc-b/lernkube
    cd lernkube
    cp templates/DUK-DEMO.yaml config.yaml
    vagrant up
    
**ACHTUNG**: die Umgebung braucht 32 GB RAM, 40 GB HD und eine CPU mit min. 4 Kernen.

### Beispiele

* [Helm](https://github.com/mc-b/duk/tree/master/helm)
* [RBAC-Autorisierung](https://github.com/mc-b/duk/tree/master/rbac/)
* [Service Mesh](https://github.com/mc-b/duk/tree/master/istio/) mit [Istio](http://istio.io)
* [Monitoring](https://github.com/mc-b/duk/tree/master/prometheus/)



    