--- agent.py.orig	2016-09-03 10:51:39 UTC
+++ agent.py
@@ -48,8 +48,8 @@ from utils.service_discovery.config_stor
 from utils.service_discovery.sd_backend import get_sd_backend
 
 # Constants
-PID_NAME = "dd-agent"
-PID_DIR = None
+PID_NAME = "collector"
+PID_DIR = "%%RUNDIR%%"
 WATCHDOG_MULTIPLIER = 10
 RESTART_INTERVAL = 4 * 24 * 60 * 60  # Defaults to 4 days
 START_COMMANDS = ['start', 'restart', 'foreground']
