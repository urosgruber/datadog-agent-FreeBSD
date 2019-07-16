--- pkg/config/config_nix.go.orig	2019-07-22 00:27:56 UTC
+++ pkg/config/config_nix.go
@@ -9,9 +9,9 @@
 package config

 const (
-	defaultConfdPath            = "/etc/datadog-agent/conf.d"
-	defaultAdditionalChecksPath = "/etc/datadog-agent/checks.d"
-	defaultRunPath              = "/opt/datadog-agent/run"
+	defaultConfdPath            = "/usr/local/etc/datadog-agent/conf.d"
+	defaultAdditionalChecksPath = "/usr/local/etc/datadog-agent/checks.d"
+	defaultRunPath              = "/var/run/datadog"
 	defaultSyslogURI            = "unixgram:///dev/log"
 	defaultGuiPort              = -1
 )
