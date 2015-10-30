--- setup.py.orig	2015-10-30 19:34:46 UTC
+++ setup.py
@@ -20,7 +20,7 @@ setup_requires = []
 install_requires = []
 
 # Modified on mac
-app_name = 'datadog-agent'
+app_name = 'dd-agent'
 # plist (used only on mac)
 plist = None
 
@@ -155,7 +155,8 @@ setup(
     url='http://www.datadoghq.com',
     install_requires=install_requires,
     setup_requires=setup_requires,
-    packages=find_packages(),
+    package_dir={'dd-agent': '.'},
+    packages=['dd-agent','dd-agent.utils','dd-agent.checks','dd-agent.checks.libs','dd-agent.checks.libs.vmware','dd-agent.checks.system','dd-agent.dogstream','dd-agent.resources','dd-agent.tests'],
     include_package_data=True,
     test_suite='nose.collector',
     zip_safe=False,
