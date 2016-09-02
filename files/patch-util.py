--- util.py.orig	2016-08-04 21:31:51 UTC
+++ util.py
@@ -33,7 +33,6 @@ except ImportError:
 # if a user actually uses them in a custom check
 # If you're this user, please use utils.pidfile or utils.platform instead
 # FIXME: remove them at a point (6.x)
-from utils.dockerutil import DockerUtil
 from utils.pidfile import PidFile  # noqa, see ^^^
 from utils.platform import Platform
 from utils.proxy import get_proxy
@@ -200,13 +199,6 @@ def get_hostname(config=None):
             if is_valid_hostname(gce_hostname):
                 return gce_hostname
 
-    # Try to get the docker hostname
-    docker_util = DockerUtil()
-    if hostname is None and docker_util.is_dockerized():
-        docker_hostname = docker_util.get_hostname()
-        if docker_hostname is not None and is_valid_hostname(docker_hostname):
-            hostname = docker_hostname
-
     # then move on to os-specific detection
     if hostname is None:
         def _get_hostname_unix():
