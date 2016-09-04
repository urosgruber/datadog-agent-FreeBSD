--- dogstatsd.py.orig	2016-09-03 10:52:31 UTC
+++ dogstatsd.py
@@ -53,7 +53,7 @@ requests_log.propagate = True
 log = logging.getLogger('dogstatsd')
 
 PID_NAME = "dogstatsd"
-PID_DIR = None
+PID_DIR = "%%RUNDIR%%"
 
 # Dogstatsd constants in seconds
 DOGSTATSD_FLUSH_INTERVAL = 10
