# cert-app

## Criar helm

```bash
helm create cert-app
```

## Instalar

> Esse deployment utiliza ingress. Verifique se o seu cluster tem um ingress-controller instalado. Você pode verificar executando o comando `kubectl get namespaces` e procurar por algum com o nome ingress ou `kubectl get ingress --all-namespaces` para verificar se tem alguma configuração usando o ingress. Caso não tenha nenhum instalado e você tem permissão para instalá-lo, siga as instruções em: [Ingress - Installation Guide](https://kubernetes.github.io/ingress-nginx/deploy/).

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
NAME                            READY   STATUS    RESTARTS   AGE
pod/cert-app-64d4d4b788-w5dmp   1/1     Running   2          3d

NAME               TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/cert-app   ClusterIP   10.0.199.49   <none>        5000/TCP   3d

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cert-app   1/1     1            1           3d

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/cert-app-64d4d4b788   1         1         1       3d
```

```bash
kubectl logs -f pod/cert-app-64d4d4b788-w5dmp -n adsantos # funciona até reiniciar o pod

kubectl logs -f -l app.kubernetes.io/name=cert-app -n adsantos # funciona sempre
...
[pid: 9|app: 0|req: 64/514] 10.240.0.66 () {30 vars in 349 bytes} [Sat Sep 12 23:56:04 2020] GET / => generated 2 bytes in 0 msecs (HTTP/1.1 200) 2 headers in 78 bytes (1 switches on core 0)
[pid: 8|app: 0|req: 337/515] 10.240.0.72 () {48 vars in 944 bytes} [Sat Sep 12 23:56:00 2020] GET /get-cert?p=Stela%20Tiberio => generated 232972 bytes in 5900 msecs via sendfile() (HTTP/1.1 200) 7 headers in 311 bytes (0 switches on core 0)
...
```

### Executando o serviço

```bash
export SERVICE_IP=$(kubectl get svc --namespace adsantos cert-app --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

echo http://$SERVICE_IP:80

http://13.89.140.64/get-cert?p=Gabriel
```
