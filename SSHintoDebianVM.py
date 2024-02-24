# Quick script for testing SSH connection into a Debian Linux VM from MacOS Sonoma.
import paramiko


def ssh_into_vm(host, username, password):
  # Create new SSH client with Paramiko.
  ssh = paramiko.SSHClient()
  # Automatically add host key for the remote server/VM to local host keys database.
  ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    ssh.connect(host, username=username, password=password)
    print("SSH connection test successful.\n")
    # Execute basic directory and list (hidden files too) commands on remote VM to verify successful SSH connection.
    stdin, stdout, stderr = ssh.exec_command('pwd && ls -a')
    # Decode output from bytes to string.
    print(stdout.read().decode())
    ssh.close()
    print("Closing SSH connection.")
  except paramiko.AuthenticationException:
    print("Authentication failed. Please check credentials.")
  except paramiko.SSHException as e:
    print(f"SSH connection failed: {e}")


# Prevent this script from running automatically if imported as a module.
if __name__ == "__main__":
  # Replace host IP with valid local IP. Replace "debian" with different username and password.
  ssh_into_vm('192.168.64.6', 'debian', 'debian')
