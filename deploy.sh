docker build -t tfurnell/multi-client:latest -t tfurnell/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tfurnell/multi-server:latest -t tfurnell/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tfurnell/multi-worker:latest -t tfurnell/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tfurnell/multi-client:latest
docker push tfurnell/multi-server:latest
docker push tfurnell/multi-worker:latest

docker push tfurnell/multi-client:$SHA
docker push tfurnell/multi-server:$SHA
docker push tfurnell/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tfurnell/multi-server:$SHA
kubectl set image deployments/client-deployment client=tfurnell/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tfurnell/multi-worker:$SHA
