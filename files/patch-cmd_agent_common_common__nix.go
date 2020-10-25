--- cmd/agent/common/common_nix.go.orig	2020-10-25 06:45:06 UTC
+++ cmd/agent/common/common_nix.go
@@ -10,6 +10,8 @@ package common
 
 import (
 	"path/filepath"
+
+	"github.com/DataDog/datadog-agent/pkg/util/log"
 )
 
 const (
@@ -30,6 +32,7 @@ var (
 
 // GetDistPath returns the fully qualified path to the 'dist' directory
 func GetDistPath() string {
+	log.Infof("Get Dist Path '%s' (%s)", _here, distPath)
 	return distPath
 }
 
