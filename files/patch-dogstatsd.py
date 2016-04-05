--- dogstatsd.py.orig	2016-04-05 16:49:39 UTC
+++ dogstatsd.py
@@ -48,7 +48,7 @@ requests_log.propagate = True
 log = logging.getLogger('dogstatsd')
 
 PID_NAME = "dogstatsd"
-PID_DIR = None
+PID_DIR = "/var/run/datadog"
 
 # Dogstatsd constants in seconds
 DOGSTATSD_FLUSH_INTERVAL = 10
