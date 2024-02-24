# Quick script for MacOS Sonoma to check for system updates.
import subprocess


def check_for_updates():
    print("Checking for software updates...")
    # Use subprocess module to return output instead of exit code.
    result = subprocess.check_output(['softwareupdate', '-l']).decode('utf-8')
    if "No new software available" in result:
        print("No new software available")
    else:
        print(result)


# Prevent this script from running automatically if imported as a module.
if __name__ == "__main__":
    check_for_updates()
