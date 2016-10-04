--- utils/hostname.py.orig	2016-10-04 21:11:13 UTC
+++ utils/hostname.py
@@ -9,8 +9,6 @@ import socket
 
 # project
 from utils.cloud_metadata import EC2, GCE
-from utils.dockerutil import DockerUtil
-from utils.kubeutil import KubeUtil
 from utils.platform import Platform
 from utils.subprocess_output import get_subprocess_output
 
@@ -72,21 +70,6 @@ def get_hostname(config=None):
         if is_valid_hostname(gce_hostname):
             return gce_hostname
 
-    # Try to get the docker hostname
-    if Platform.is_containerized():
-
-        # First we try from the Docker API
-        docker_util = DockerUtil()
-        docker_hostname = docker_util.get_hostname(use_default_gw=False)
-        if docker_hostname is not None and is_valid_hostname(docker_hostname):
-            hostname = docker_hostname
-
-        elif Platform.is_k8s(): # Let's try from the kubelet
-            kube_util = KubeUtil()
-            _, kube_hostname = kube_util.get_node_info()
-            if kube_hostname is not None and is_valid_hostname(kube_hostname):
-                hostname = kube_hostname
-
     # then move on to os-specific detection
     if hostname is None:
         if Platform.is_unix() or Platform.is_solaris():
