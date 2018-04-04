# GKE Helm Deployer

Docker container with kubectl and helm for use in deploying and CI/CD. Includes script
to make authentication with GKE easier.

## Authentication

Authentication with GKE is supported via a service account key. To be useful it needs to
have the following roles:

* Kubernetes Engine Developer - for doing the deployment
* Storage Admin - if you need to push to the container registry

The authenticate script expects the service account key to be mounted at
```/secrets/service-account.json```.
The key filename can be configured via the ```G_SERVICE_ACCOUNT``` environment variable.

Also required are the cluster details which are specified via the following env variables:

* ```G_USER``` - User associated with service account. E.g., ```deployer@project.iam.gserviceaccount.com```
* ```G_PROJECT```
* ```G_CLUSTER```
* ```G_REGION```
* ```G_ZONE```

## Usage

Running the image with no command will drop you into a bash prompt with authenticated
```helm``` and ```kubectl``` in the path.
