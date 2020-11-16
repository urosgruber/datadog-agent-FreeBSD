--- vendor/github.com/DataDog/zstd/zstd_stream.go.orig	2020-11-16 17:16:24 UTC
+++ vendor/github.com/DataDog/zstd/zstd_stream.go
@@ -1,6 +1,7 @@
 package zstd
 
 /*
+#define ZSTD_STATIC_LINKING_ONLY
 #include "zstd.h"
 #include "zstd_buffered.h"
 */
