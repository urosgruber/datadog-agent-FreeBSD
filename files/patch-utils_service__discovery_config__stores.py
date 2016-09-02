--- utils/service_discovery/config_stores.py.orig	2016-08-05 07:20:13 UTC
+++ utils/service_discovery/config_stores.py
@@ -6,11 +6,8 @@
 from utils.service_discovery.abstract_config_store import AbstractConfigStore
 from utils.service_discovery.abstract_config_store import CONFIG_FROM_AUTOCONF, CONFIG_FROM_FILE, CONFIG_FROM_TEMPLATE, TRACE_CONFIG  # noqa imported somewhere else
 
-from utils.service_discovery.etcd_config_store import EtcdStore
-from utils.service_discovery.consul_config_store import ConsulStore
-
 
-SD_CONFIG_BACKENDS = ['etcd', 'consul']  # noqa: used somewhere else
+SD_CONFIG_BACKENDS = []  # noqa: used somewhere else
 SD_TEMPLATE_DIR = '/datadog/check_configs'
 
 
