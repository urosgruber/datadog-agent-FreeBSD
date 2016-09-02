--- utils/service_discovery/sd_backend.py.orig	2016-08-05 07:19:39 UTC
+++ utils/service_discovery/sd_backend.py
@@ -5,13 +5,11 @@
 # std
 import logging
 
-# project
-from utils.service_discovery.sd_docker_backend import SDDockerBackend
 
 log = logging.getLogger(__name__)
 
 AUTO_CONFIG_DIR = 'auto_conf/'
-SD_BACKENDS = ['docker']
+SD_BACKENDS = []
 
 
 def get_sd_backend(agentConfig):
