clean_merged_branch
===================

## Description
  
  After pull request merged into main branch, at this time, maybe you will forget to delete merged branch, 

or due to some reasons, you want to delete merged branch when this sprint(agile development) finish. By using

this rake task, you can delete merged branch easily in local and remote. In order to avoid mistake, 

in this tool, we do not allow to delete all merged branch automatically. 


## Environment
  
 `Ruby 1.9.2` and `Ruby 1.9.3`

## How to use
  
  For example, you want to delete merged branch `pr-WEB-12345` in `main_branch` 

* Put this rake task to your rails root and under lib/tasks folders. 

* `git checkout main_branch`

* Bundle exec rake tool:clean_merged_branch

* input some keywords about branch name like `pr-WEB-12345` (For us, normally, we put JIRA number as part of branch name)

* Following the message to input `Y` or `N` to delete local or remote branch.
