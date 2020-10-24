--- rtloader/common/rtloader_mem.h.orig	2020-01-31 16:08:09.641074000 +0000
+++ rtloader/common/rtloader_mem.h	2020-01-31 15:53:55.781730000 +0000
@@ -69,6 +69,8 @@
 #        define __THROW
 #    elif __APPLE__
 #        define __THROW
+#    elif __FreeBSD__
+#        define __THROW
 #    endif
 
 char *strdupe(const char *s1) __THROW;
