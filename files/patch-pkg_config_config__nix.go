--- pkg/config/config_nix.go.orig	2020-05-11 15:38:36 UTC
+++ pkg/config/config_nix.go
@@ -9,9 +9,9 @@
 package config
 
 const (
-	defaultConfdPath            = "/etc/datadog-agent/conf.d"
-	defaultAdditionalChecksPath = "/etc/datadog-agent/checks.d"
-	defaultRunPath              = "/opt/datadog-agent/run"
+	defaultConfdPath            = "/usr/local/etc/datadog/conf.d"
+	defaultAdditionalChecksPath = "/usr/local/etc/datadog/checks.d"
+	defaultRunPath              = "/var/run/datadog"
 	defaultSyslogURI            = "unixgram:///dev/log"
 	defaultGuiPort              = -1
 )
