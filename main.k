import kind.v1alpha4 as kind
import kubeadm.v1beta3 as kubeadm 
import yaml
import k8sconfig.v1 as k8sconfig

_kubeadmpatches=[]

_nodes = [
]


_clusterConfiguration=kubeadm.ClusterConfiguration{
    apiServer: kubeadm.ApiServer{}
}

_extraVolumes=[kubeadm.ExtraVolumeItem{
    "name" = "audit-logs"
    "hostPath" = "/var/log/audit"
    "mountPath" = "/var/log/audit"
}]

_apiServerExtraArgs={
    "runtime-config" = "api/all=true"
    "storage-media-type" =  option("storageMediaType",default="application/json")
    "audit-log-path" = "/var/log/audit/kube-apiserver-audit.log"
    "audit-policy-file" = "/etc/kubernetes/audit-policy/apiserver-audit-policy.yaml"
}

_apiServerExtraArgsEnabled=option("apiServerExtraArgsEnabled",default=False)
if _apiServerExtraArgsEnabled:
    _clusterConfiguration.apiServer.extraArgs=_apiServerExtraArgs


_apiServerExtraVolumesEnabled=option("apiServerExtraVolumesEnabled",default=False)
if _apiServerExtraVolumesEnabled:
    _clusterConfiguration.apiServer.extraVolumes=_extraVolumes


_server_yaml = yaml.encode(_clusterConfiguration)

_result = [(lambda x: int -> int {
    _nodes+=[kind.Node{
        role = "control-plane"
        image = option("image",default="kindest/node:v1.30.2")
        kubeadmConfigPatches = [
            _server_yaml
        ]
    }
    ]
    x
})(x) for x in range(0,option("cpcount",default=1))]


_result = [(lambda x: int -> int {
    _nodes+=[{
        role = "worker"
        image = option("image",default="kindest/node:v1.30.2")
    }
    ]
    x
})(x) for x in range(0,option("workercount",default=0))]

kind.Cluster{
    nodes = _nodes
}


c=k8sconfig.KubeSchedulerConfiguration{}