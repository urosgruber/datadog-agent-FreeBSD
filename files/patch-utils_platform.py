--- utils/platform.py.orig	2015-12-09 17:04:46 UTC
+++ utils/platform.py
@@ -1,10 +1,7 @@
 # stdlib
 import sys
 
-# project
-from utils.dockerutil import get_client
-
-_is_ecs = None
+_is_ecs = False
 
 class Platform(object):
     """
