diff --git a/xhprof_html/index.php b/xhprof_html/index.php
index f21d32f..7d3e8df 100644
--- a/xhprof_html/index.php
+++ b/xhprof_html/index.php
@@ -68,7 +68,7 @@ foreach ($params as $k => $v) {
 echo "<html>";
 
 echo "<head><title>XHProf: Hierarchical Profiler Report</title>";
-xhprof_include_js_css();
+xhprof_include_js_css($base_path_prefix);
 echo "</head>";
 
 echo "<body>";
diff --git a/xhprof_lib/display/xhprof.php b/xhprof_lib/display/xhprof.php
index a57ec17..e531cba 100644
--- a/xhprof_lib/display/xhprof.php
+++ b/xhprof_lib/display/xhprof.php
@@ -1,4 +1,5 @@
 <?php
+$base_path_prefix = isset($_SERVER['XHPROF_URL_PREFIX']) ? $_SERVER['XHPROF_URL_PREFIX'] : '';
 //  Copyright (c) 2009 Facebook
 //
 //  Licensed under the Apache License, Version 2.0 (the "License");
@@ -42,7 +43,7 @@ require_once $GLOBALS['XHPROF_LIB_ROOT'].'/utils/xhprof_runs.php';
  * Our coding convention disallows relative paths in hrefs.
  * Get the base URL path from the SCRIPT_NAME.
  */
-$base_path = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/\\');
+$base_path = rtrim($base_path_prefix.'/'.dirname($_SERVER['SCRIPT_NAME']), '/\\');
 
 
 /**
diff --git a/xhprof_lib/utils/xhprof_runs.php b/xhprof_lib/utils/xhprof_runs.php
index 2a22a5d..79fc5e3 100644
--- a/xhprof_lib/utils/xhprof_runs.php
+++ b/xhprof_lib/utils/xhprof_runs.php
@@ -146,13 +146,14 @@ class XHProfRuns_Default implements iXHProfRuns {
   }
 
   function list_runs() {
+    global $base_path_prefix;
     if (is_dir($this->dir)) {
         echo "<hr/>Existing runs:\n<ul>\n";
         $files = glob("{$this->dir}/*.{$this->suffix}");
         usort($files, create_function('$a,$b', 'return filemtime($b) - filemtime($a);'));
         foreach ($files as $file) {
             list($run,$source) = explode('.', basename($file));
-            echo '<li><a href="' . htmlentities($_SERVER['SCRIPT_NAME'])
+            echo '<li><a href="' . $base_path_prefix . htmlentities($_SERVER['SCRIPT_NAME'])
                 . '?run=' . htmlentities($run) . '&source='
                 . htmlentities($source) . '">'
                 . htmlentities(basename($file)) . "</a><small> "
