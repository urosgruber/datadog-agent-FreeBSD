--- utils/platform.py.orig	2016-09-02 21:49:25 UTC
+++ utils/platform.py
@@ -5,10 +5,7 @@
 # stdlib
 import sys
 
-# project
-from utils.dockerutil import DockerUtil
-
-_is_ecs = None
+_is_ecs = False
 
 class Platform(object):
     """
@@ -72,4 +69,5 @@ class Platform(object):
 
     @staticmethod
     def is_ecs_instance():
-        return DockerUtil().is_ecs()
+        return False
+
