import kind.v1alpha4 as kind

_nodes = [
]

_result = [(lambda x: int -> int {
    _nodes+=[{
        role = "control-plane"
        image = option("image",default="kindest/node:v1.30.0")
    }
    ]
    x
})(x) for x in range(0,option("cpcount",default=1))]


_result = [(lambda x: int -> int {
    _nodes+=[{
        role = "worker"
        image = option("image",default="kindest/node:v1.30.0")
    }
    ]
    x
})(x) for x in range(0,option("workercount",default=0))]

kind.Cluster{
    nodes = _nodes
}
