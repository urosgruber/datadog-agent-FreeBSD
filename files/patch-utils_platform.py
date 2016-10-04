--- utils/platform.py.orig	2016-10-04 20:42:20 UTC
+++ utils/platform.py
@@ -84,8 +84,7 @@ class Platform(object):
 
     @staticmethod
     def is_ecs_instance():
-        from utils.dockerutil import DockerUtil
-        return DockerUtil().is_ecs()
+        return False
 
     @staticmethod
     def is_containerized():
