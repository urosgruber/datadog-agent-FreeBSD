--- setup.py.orig	2015-10-26 18:27:01 UTC
+++ setup.py
@@ -20,7 +20,7 @@ setup_requires = []
 install_requires = []
 
 # Modified on mac
-app_name = 'datadog-agent'
+app_name = 'datadog'
 # plist (used only on mac)
 plist = None
 
@@ -155,7 +155,13 @@ setup(
     url='http://www.datadoghq.com',
     install_requires=install_requires,
     setup_requires=setup_requires,
-    packages=find_packages(),
+    package_dir={'datadog': '.'},
+    packages=[
+          'datadog', 'datadog.utils', 'datadog.checks', 
+          'datadog.checks.libs', 'datadog.checks.libs.vmware', 'datadog.checks.system',
+          'datadog.dogstream', 'datadog.resources',
+          'datadog.tests'
+    ],
     include_package_data=True,
     test_suite='nose.collector',
     zip_safe=False,
