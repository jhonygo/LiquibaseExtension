#Liquibase extension for TFS/VSTS

###Purpose  
  
This extension aims to provide build/release tasks for Liquibase runner.  
This is a first version acting as a wrapper, without much semantic logic. Feel free to contribute if you have a better plan : https://github.com/jhonygo/LiquibaseExtension
  
###Introduction to Liquibase framework  
Liquibase is a database migration and configuration management tool. Here are some key features:  
  
- Generate an initial state of a database structure  
- Perform atomic database updates  
- Execute iterative updates based on changesets checksum computation  
- Supports SQL, but also JSON/Yaml/XML changesets  
- Automated SQL update/rollback scripts generation (JSON/Yaml/XML)  
  
For details see [liquibase homepage](http://www.liquibase.org).  
  
###Main logic  
  
The Liquibase extension contains the liquibase framework (java archive) and JDBC JTDS driver for Sybase/SQL Server DBMSes.  
It allows to choose an action taken from a list of available liquibase commands against a given changelog package provided and a database connection.  
Some additional options can be defined if needed.  
  
Some pointers:  
- [changelog reference](http://www.liquibase.org/documentation/databasechangelog.html)  
- [changeset reference](http://www.liquibase.org/documentation/changeset.html)  
- [quick start](http://www.liquibase.org/quickstart.html)  
  