# cert-app

## run

```bash
cd cert-app/app

flask run
```

```bash
cd kdop/cert-app
docker build -t kdop/cert-app:0.0.6 .

docker push kdop/cert-app:0.0.6
```

```bash
docker run -p 5000:5000 kdop/cert-app:0.0.6
```

## Testing

<http://127.0.0.1:5000/get-cert?p=Anderson%20Santos>

<http://127.0.0.1:5000/get-cert?p=Maristela>

<http://13.89.140.64:5000/get-cert?p=Gabriel>

## Helm

```bash
helm upgrade --install --namespace kdop-learn --create-namespace cert-app cert-app
```
