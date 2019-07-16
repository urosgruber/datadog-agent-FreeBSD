--- rtloader/rtloader/api.cpp.orig	2019-07-15 23:58:24 UTC
+++ rtloader/rtloader/api.cpp
@@ -24,6 +24,9 @@
 #elif _WIN32
 #    define DATADOG_AGENT_TWO "libdatadog-agent-two.dll"
 #    define DATADOG_AGENT_THREE "libdatadog-agent-three.dll"
+#elif __FreeBSD__
+#    define DATADOG_AGENT_TWO "libdatadog-agent-two.so"
+#    define DATADOG_AGENT_THREE "libdatadog-agent-three.so"
 #else
 #    error Platform not supported
 #endif
