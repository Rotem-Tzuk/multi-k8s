docker build -t rotemtzuk/multi-client:latest -t rotemtzuk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rotemtzuk/multi-server:latest -t rotemtzuk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rotemtzuk/multi-worker:latest -t rotemtzuk/multi-worker:$SHA -f ./-worker/Dockerfile ./-worker

docker push rotemtzuk/multi-client:latest
docker push rotemtzuk/multi-server:latest
docker push rotemtzuk/multi-worker:latest

docker push rotemtzuk/multi-client:$SHA
docker push rotemtzuk/multi-server:$SHA
docker push rotemtzuk/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rotemtzuk/multi-server:$SHA
kubectl set image deployments/client-deployment client=rotemtzuk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rotemtzuk/multi-worker:$SHA