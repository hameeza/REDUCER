**Steps to use REDUCER in Linux OS are as follows;**

Inside application folder (App_name) create folder "output/App_name". App_name is the application name like bzip2d.

Copy the given scripts in application folder containing source code.

Inside app_name create folders "exe-files", "object", "selected-IR".

Directory structure: app_name->output->app_name-> "exe-files", "object", "selected-IR".

Run "bash initial-compilations.sh".

Run "md5sum < "output/$App_name/selected-IR/$App_name-noopt-o3.ll" > match.csv".

Run "bash REDUCER.sh".

Run "bash compilation-IRtoexe.sh".
