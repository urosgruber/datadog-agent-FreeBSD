--- agent.py.orig	2016-04-05 16:49:39 UTC
+++ agent.py
@@ -46,7 +46,7 @@ from utils.profile import AgentProfiler
 
 # Constants
 PID_NAME = "dd-agent"
-PID_DIR = None
+PID_DIR = "/var/run/datadog"
 WATCHDOG_MULTIPLIER = 10
 RESTART_INTERVAL = 4 * 24 * 60 * 60  # Defaults to 4 days
 START_COMMANDS = ['start', 'restart', 'foreground']
