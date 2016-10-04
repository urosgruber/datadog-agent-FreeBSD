--- utils/configcheck.py.orig	2016-10-04 20:38:28 UTC
+++ utils/configcheck.py
@@ -13,7 +13,6 @@ from config import (
     get_confd_path
 )
 from utils.hostname import get_hostname
-from utils.dockerutil import DockerUtil
 from utils.service_discovery.config_stores import get_config_store, SD_CONFIG_BACKENDS, TRACE_CONFIG
 
 
@@ -61,11 +60,6 @@ def get_sd_configcheck(agentConfig, conf
         print('Check "%s":\n  source --> %s\n  config --> %s\n' % (check_name, config[0], config[1]))
 
     try:
-        print_containers()
-    except Exception:
-        print("Failed to collect containers info.")
-
-    try:
         print_templates(agentConfig)
     except Exception:
         print("Failed to collect configuration templates.")
