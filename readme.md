# Node-Red Dashboard Scripts Information
This script will install all the dependencies to run the contest dashboard. 

For more information about the Node-Red Contesting Dashboard head to the [repo](https://github.com/kylekrieg/Node-Red-Contesting-Dashboard).  
For more information about the Node-Red POTA Dashboard head to the [repo](https;//github.com/kylekrieg/Node-Red-POTA-Dashboard).

## Requirements
* Debian 11 based installition (Raspberry PI OS Bullseye, Ubuntu 22.04 LTS or Newer ,...) APT Package Manager is used.

## Process
1. Asks initial questions on updating host machinem, updating the dashboard, and planning to help develop the dashbaord

## Phases of the Script
1. Updates host machine to latest packages
2. Install/Update NodeRed (if selected by user)
3. Install/Update Git
4. Install/update SQLite3
5. Configure SQLite database
6. Install/Overwrite settings.js file for NodeRed 
    * This is done to allow Node-Red projects (key requirement) to work properly
7. Clone/Update Node-Red dashboard Flow and associated files
8. Install node dependencies for the Dashboard
9. Enable and restart Node-Red systemd service

## Dependencies installed
* All packeges used in Node-Red install script developed by Node-Red 
* SQLite3
* Git

### Contribution
Feel free to create an issue/pull requests for any bugs or new features that you see. You can also reach out on the [nodered-hamradio groups,io](https://groups.io/g/nodered-hamradio) if you are having trouble using the script. Please make sure that you add `#contest-dashbaord` to the subject line to receive a timely response. 

## References
[Node-Red Installation Guide](https://nodered.org)

## Future Ideas
* Create a script that generates the config file that can be implemented via clicking the restore function on the dashboard
* Develop Windows Batch Script to install NR and Contest Dashboard
* Allow user to disable Node-Red projects
