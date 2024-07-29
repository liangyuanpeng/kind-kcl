schema KubeSchedulerConfiguration:
    apiVersion: str =  "kubescheduler.config.k8s.io/v1"
    kind: str = "KubeSchedulerConfiguration"
    clientConnection?: ClientConnection

schema ClientConnection:
    kubeconfig?: str
    acceptContentTypes?: str
    contentType?: str