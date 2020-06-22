docker build -t tk2232/multi-client:latest -t tk2232/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tk2232/multi-server:latest -t tk2232/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tk2232/multi-worker:latest -t tk2232/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tk2232/multi-client:latest
docker push tk2232/multi-server:latest
docker push tk2232/multi-worker:latest

docker push tk2232/multi-client:$SHA
docker push tk2232/multi-server:$SHA
docker push tk2232/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tk2232/multi-server:$SHA
kubectl set image deployments/client-deployment client=tk2232/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tk2232/multi-worker:$SHA