kubectl create namespace prometheus
helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus -f values_prom.yaml

kubectl --namespace=monitoring port-forward deploy/prometheus-server 9090

helm install grafana grafana/grafana \
  --namespace prometheus \
  --set adminPassword='admin'

kubectl --namespace=monitoring port-forward deploy/grafana 3000

kubectl --namespace=monitoring port-forward pod/prometheus-alertmanager-0 9093


Grafana dashboard
15760

wget -qO http://prometheus-server.prometheus.svc.cluster.local:9090
wget -qO http://prometheus-alertmanager.monitoring.svc.cluster.local:9093

http://prometheus-server.prometheus.svc.cluster.local:9090

Put load on nginx container
while true; do curl -s -o /dev/null http://localhost; done

while true; do curl -s -o /dev/null http://localhost/hello; done


MOnitoring microservices
Update the microservicecd
http://localhost/actuator/prometheus