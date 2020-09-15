# cert-app

## Criar helm

```bash
helm create cert-app
```

## Instalar

Teste

```bash
helm install --namespace adsantos --create-namespace cert-app ./cert-app --dry-run --debug
```

Pra valer

```bash
helm install --namespace adsantos --create-namespace cert-app ./cert-app

Release "cert-app" has been upgraded. Happy Helming!
NAME: cert-app
LAST DEPLOYED: Mon Sep  7 00:14:22 2020
NAMESPACE: adsantos
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
     NOTE: It may take a few minutes for the LoadBalancer IP to be available.
           You can watch the status of by running 'kubectl get --namespace adsantos svc -w cert-app'
  export SERVICE_IP=$(kubectl get svc --namespace adsantos cert-app --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")     
  echo http://$SERVICE_IP:80
```

### Atualizar

```bash
helm upgrade --namespace adsantos cert-app ./cert-app
```

### Excluir

```bash
helm delete --namespace adsantos cert-app
```

Verificando

```bash
kubectl get all -n adsantos

NAME                            READY   STATUS    RESTARTS   AGE
pod/cert-app-64d4d4b788-kkc98   1/1     Running   0          13m

NAME               TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
service/cert-app   LoadBalancer   10.0.161.44   13.89.140.64   80:32282/TCP   17m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cert-app   1/1     1            1           17m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/cert-app-64d4d4b788   1         1         1       13m
```

```bash
kubectl logs -f pod/cert-app-64d4d4b788-kkc98 -n adsantos # funciona até reiniciar o pod

kubectl logs -f -l app.kubernetes.io/name=cert-app -n adsantos # funciona sempre
```

### Executando o serviço

```bash
export SERVICE_IP=$(kubectl get svc --namespace adsantos cert-app --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

echo http://$SERVICE_IP:80

http://13.89.140.64/get-cert?p=Gabriel%20Tiberio
```
