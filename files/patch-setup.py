--- setup.py.orig	2016-03-31 15:25:24 UTC
+++ setup.py
@@ -21,7 +21,7 @@ setup_requires = []
 install_requires = []
 
 # Modified on mac
-app_name = 'datadog-agent'
+app_name = 'datadog'
 # plist (used only on mac)
 plist = None
 
@@ -168,7 +168,13 @@ setup(
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
