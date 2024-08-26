#!/bin/bash

# Function for logging messages
log_message() {
  echo -e "\n\033[1m$1\033[0m"
}

# Function to check user and group audits
check_users_and_groups() {
  log_message "Checking users and groups..."

  # List all users and groups
  cat /etc/passwd | cut -d: -f1
  cat /etc/group | cut -d: -f1

  # Check for non-standard root users
  awk -F: '$3 == 0 { print $1 }' /etc/passwd | grep -v root

  # Identify users without passwords or weak passwords
  grep -v '^#' /etc/passwd | awk -F: '$2 == "" { print <span class="math-inline">1 \}'
\# Can be enhanced to check password strength using tools like cracklib\-checkpw
\}
\# Function to check file and directory permissions
check\_permissions\(\) \{
log\_message "Checking file and directory permissions\.\.\."
\# Scan for world\-writable files \(excluding temporary directories\)
find / \-perm \-002 \| grep \-v "/tmp/" \| grep \-v "/var/log/"
\# Check \.ssh directory permissions
find / \-type d \-name "\.ssh" \-exec ls \-ld \{\} \\; \| grep \-v 700
\# Report SUID/SGID bits on executables
find / \-perm \-4000 \-type f
\}
\# Function to check service audits
check\_services\(\) \{
log\_message "Checking services\.\.\."
\# List all running services
systemctl list\-units \-\-type service
\# Check status of critical services \(modify as needed\)
systemctl status sshd iptables
\# Identify non\-standard or insecure ports
netstat \-tulpn \| grep \-v "\:22 " \| grep \-v "\:80 " \| grep LISTEN
\}
\# Function to check firewall and network security
check\_firewall\_and\_network\(\) \{
log\_message "Checking firewall and network security\.\.\."
\# Verify firewall status \(adapt for your firewall tool\)
if command \-v ufw &\> /dev/null; then
ufw status
elif command \-v iptables &\> /dev/null; then
iptables \-L
else
echo "No firewall detected\."
fi
\# Report open ports and associated services
netstat \-tulpn
\# Check for IP forwarding
sysctl \-a \| grep \-i "ip\_forward"
\}
\# Function to check IP and network configuration
check\_ip\_and\_network\(\) \{
log\_message "Checking IP and network configuration\.\.\."
\# Get all IP addresses
ip addr show
\# Identify public vs private IPs \(using online resources or APIs\)
\# Example using external API \(replace with your preferred method\)
PUBLIC\_IP\=</span>(curl -s https://icanhazip.com)
  for iface in $(ip addr show | grep 'link/ether' | awk '{print <span class="math-inline">2\}'\); do
IP\=</span>(ip addr show $iface | grep 'inet\ ' | awk '{print $2}')
    if [[ "$IP" == "$PUBLIC_IP" ]]; then
      echo "$IP (Public)"
    else
      echo "$IP (Private)"
    fi
  done

  # Check for exposed sensitive services on public IPs
  netstat -tulpn | grep ":22 " | grep '0.0.0.0:'  # Check for SSH on public interface
  # Add checks for other sensitive services as needed
}

# Function to check security updates and patching
check_updates_and_patches() {
  log_message "Checking security updates and patching..."

  # Update package list and check for available updates (modify for your package manager)
  apt update && apt list --upgradeable

  # Verify automatic update configuration (check systemd timers or unattended-upgrades)
  # Add checks based on your update management system
}

# Function to check log monitoring
check_log_monitoring() {
  log_message "Checking log monitoring..."

  # Analyze recent auth logs for suspicious activity
  tail -n 100 /var/log/auth.log | grep "Failed login attempt"

  # Consider integrating tools like logwatch for more advanced analysis
}

# Function to harden SSH
harden_ssh() {
  log_message "Hardening
