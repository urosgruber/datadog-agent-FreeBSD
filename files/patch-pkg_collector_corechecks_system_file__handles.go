--- pkg/collector/corechecks/system/file_handles.go.orig        2020-03-19 20:04:59 UTC
+++ pkg/collector/corechecks/system/file_handles.go
@@ -3,6 +3,7 @@
 // This product includes software developed at Datadog (https://www.datadoghq.com/).
 // Copyright 2016-2019 Datadog, Inc.
 // +build !windows
+// +build !freebsd
 
 package system
 
