--- dogstatsd.py.orig	2016-08-04 21:32:19 UTC
+++ dogstatsd.py
@@ -53,7 +53,7 @@ requests_log.propagate = True
 log = logging.getLogger('dogstatsd')
 
 PID_NAME = "dogstatsd"
-PID_DIR = None
+PID_DIR = "/var/run/datadog"
 
 # Dogstatsd constants in seconds
 DOGSTATSD_FLUSH_INTERVAL = 10
