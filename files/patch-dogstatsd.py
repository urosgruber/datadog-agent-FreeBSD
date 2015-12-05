--- dogstatsd.py.orig	2015-12-05 17:31:20 UTC
+++ dogstatsd.py
@@ -46,6 +46,9 @@ requests_log.propagate = True
 
 log = logging.getLogger('dogstatsd')
 
+PID_NAME = "dogstatsd"
+PID_DIR = "/var/run/datadog"
+
 # Dogstatsd constants in seconds
 DOGSTATSD_FLUSH_INTERVAL = 10
 DOGSTATSD_AGGREGATOR_BUCKET_SIZE = 10
@@ -439,7 +442,7 @@ def main(config_path=None):
 
     if not args or args[0] in COMMANDS_START_DOGSTATSD:
         reporter, server, cnf = init(config_path, use_watchdog=True, use_forwarder=opts.use_forwarder, args=args)
-        daemon = Dogstatsd(PidFile('dogstatsd').get_path(), server, reporter,
+        daemon = Dogstatsd(PidFile(PID_NAME, PID_DIR).get_path(), server, reporter,
                            cnf.get('autorestart', False))
 
     # If no args were passed in, run the server in the foreground.
