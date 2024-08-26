# safesquid_project
Public Repository for Safesquid test project - Task 1

This Bash script provides a real-time dashboard for monitoring various system resources of a proxy server. 
It displays information such as CPU usage, memory consumption, network traffic, disk usage, and process activity.

**Usage**
1. Save the script: Save the provided Bash script as resource_monitor.sh.
2. Make it executable: Run the following command in your terminal:

             chmod +x resource_monitor.sh

4. Execute the script: Run the script:

            ./resource_monitor.sh

This will display the full dashboard, including all monitored resources.

**Calling Individual Dashboard Sections**

You can view specific sections of the dashboard by using command-line switches:

-cpu     : Displays the top 10 CPU-intensive processes.
-memory  : Shows memory usage statistics.
-network : Provides information about network traffic.
-disk    : Displays disk usage for mounted partitions.
-system  : Shows system load and CPU usage.
-process : Lists active processes and their resource consumption.
-service : Monitors the status of essential services.

Examples :

To view only the top 10 CPU-intensive processes:

    ./resource_monitor.sh -cpu

To display both memory and network information:

    ./resource_monitor.sh -memory -network
