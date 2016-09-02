--- utils/platform.py.orig	2016-03-31 15:25:24 UTC
+++ utils/platform.py
@@ -1,10 +1,7 @@
 # stdlib
 import sys
 
-# project
-from utils.dockerutil import DockerUtil
-
-_is_ecs = None
+_is_ecs = False
 
 class Platform(object):
     """
