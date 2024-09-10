
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet_vm
    access_config {
      // No public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "vm-service-account@playpen-e16de4.iam.gserviceaccount.com"
    scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/devstorage.read_write",
        "https://www.googleapis.com/auth/cloud.useraccounts.readonly"]
  }

  metadata_startup_script = <<-EOF
#!/bin/bash
# Update package list and install zip and unzip
sudo apt-get update
sudo apt-get install -y zip unzip curl

# Install SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add SDKMAN to PATH
echo 'export SDKMAN_DIR="$HOME/.sdkman"' >> ~/.bashrc
echo '[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"' >> ~/.bashrc

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source "$HOME/.nvm/nvm.sh"

# Add NVM to PATH
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc

# Reload shell configuration
source ~/.bashrc

# Verify installations
if command -v sdk > /dev/null; then
    echo "SDKMAN installed successfully"
else
    echo "SDKMAN installation failed"
fi

if command -v nvm > /dev/null; then
    echo "NVM installed successfully"
else
    echo "NVM installation failed"
fi


  EOF
}
