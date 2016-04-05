--- util.py.orig	2016-04-05 16:49:52 UTC
+++ util.py
@@ -29,7 +29,6 @@ except ImportError:
 # if a user actually uses them in a custom check
 # If you're this user, please use utils.pidfile or utils.platform instead
 # FIXME: remove them at a point (6.x)
-from utils.dockerutil import get_hostname as get_docker_hostname, is_dockerized
 from utils.pidfile import PidFile  # noqa, see ^^^
 from utils.platform import Platform
 from utils.proxy import get_proxy
