--- setup.py.orig	2016-07-25 21:41:43 UTC
+++ setup.py
@@ -25,7 +25,7 @@ setup_requires = []
 install_requires = []
 
 # Modified on mac
-app_name = 'datadog-agent'
+app_name = 'datadog'
 # plist (used only on mac)
 plist = None
 
@@ -173,7 +173,13 @@ setup(
     url='http://www.datadoghq.com',
     install_requires=install_requires,
     setup_requires=setup_requires,
-    packages=find_packages(),
+    package_dir={'datadog': '.'},
+    packages=[
+          'datadog', 'datadog.checks',
+          'datadog.utils', 'datadog.utils.service_discovery', 
+          'datadog.checks.libs', 'datadog.checks.libs.vmware', 'datadog.checks.system',
+          'datadog.dogstream'
+    ],
     include_package_data=True,
     test_suite='nose.collector',
     zip_safe=False,
