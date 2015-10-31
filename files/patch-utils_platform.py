--- utils/platform.py.orig	2015-10-31 09:07:36 UTC
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
