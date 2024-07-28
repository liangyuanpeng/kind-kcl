[package]
name = "kind-kcl"
edition = "v0.9.0"
version = "0.0.1"

[dependencies]
kind = { oci = "oci://ghcr.io/kcl-lang/kind", tag = "0.0.2" }
kubeadm = { oci = "oci://ghcr.io/kcl-lang/kubeadm", tag = "0.0.2" }

