--- util.py.orig	2016-03-31 15:25:24 UTC
+++ util.py
@@ -29,7 +29,6 @@ except ImportError:
 # if a user actually uses them in a custom check
 # If you're this user, please use utils.pidfile or utils.platform instead
 # FIXME: remove them at a point (6.x)
-from utils.dockerutil import get_hostname as get_docker_hostname, is_dockerized
 from utils.pidfile import PidFile  # noqa, see ^^^
 from utils.platform import Platform
 from utils.proxy import get_proxy
@@ -192,12 +191,6 @@ def get_hostname(config=None):
             if is_valid_hostname(gce_hostname):
                 return gce_hostname
 
-    # Try to get the docker hostname
-    if hostname is None and is_dockerized():
-        docker_hostname = get_docker_hostname()
-        if docker_hostname is not None and is_valid_hostname(docker_hostname):
-            return docker_hostname
-
     # then move on to os-specific detection
     if hostname is None:
         def _get_hostname_unix():
