--- pkg/config/config.go.orig	2019-07-19 17:50:20 UTC
+++ pkg/config/config.go
@@ -125,7 +125,7 @@ func initConfig(config Config) {
 	config.BindEnvAndSetDefault("bind_host", "localhost")
 	config.BindEnvAndSetDefault("health_port", int64(0))
 	config.BindEnvAndSetDefault("disable_py3_validation", false)
-	config.BindEnvAndSetDefault("python_version", "2")
+	config.BindEnvAndSetDefault("python_version", "3")
 	// C-land crash feature flags
 	config.BindEnvAndSetDefault("c_stacktrace_collection", false)
 	config.BindEnvAndSetDefault("c_core_dump", false)
