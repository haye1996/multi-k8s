docker build -t haitongye/multi-client:latest -t haitongye/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t haitongye/multi-server:latest -t haitongye/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t haitongye/multi-worker:latest -t haitongye/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push haitongye/multi-client:latest
docker push haitongye/multi-client:$SHA
docker push haitongye/multi-server:latest
docker push haitongye/multi-server:$SHA
docker push haitongye/multi-worker:latest
docker push haitongye/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=haitongye/multi-server:$SHA
kubectl set image deployments/client-deployment client=haitongye/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=haitongye/multi-worker:$SHA