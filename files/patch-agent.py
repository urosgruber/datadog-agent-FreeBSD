--- agent.py.orig	2016-08-04 21:32:19 UTC
+++ agent.py
@@ -49,7 +49,7 @@ from utils.service_discovery.sd_backend 
 
 # Constants
 PID_NAME = "dd-agent"
-PID_DIR = None
+PID_DIR = "/var/run/datadog"
 WATCHDOG_MULTIPLIER = 10
 RESTART_INTERVAL = 4 * 24 * 60 * 60  # Defaults to 4 days
 START_COMMANDS = ['start', 'restart', 'foreground']
