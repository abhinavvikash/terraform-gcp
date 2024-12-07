resource "google_compute_instance" "test_vm_instance" {
  name         = "foundation-component-1"
  machine_type = "n1-standard-4"
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
    email  = "vm-service-account@playpen-2f4e18.iam.gserviceaccount.com"
    scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/devstorage.read_write",
        "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
        ]
  }

  metadata_startup_script = <<-EOF
#!/bin/bash
#!/bin/bash
set -axe

# Variables
SDKMAN_INIT="$HOME/.sdkman/bin/sdkman-init.sh"
NVM_INIT="$HOME/.nvm/nvm.sh"
KAFKA_VERSION="3.8.0"
KAFKA_DIR="/root/kafka_2.13-$KAFKA_VERSION"
LOG_DIR="/root/foundation-components/logs"
GS_BUCKET="gs://playpen-2f4e18-lib-bucket"

# Create necessary directories
sudo mkdir -p /root/foundation-components $LOG_DIR
cd /root/foundation-components

# Install SDKMAN and NVM
curl -s "https://get.sdkman.io" | bash
source "$SDKMAN_INIT"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source "$NVM_INIT"

# # Install SDKs and NVM
# sdk install java 11.0.24-amzn
# sdk install java 17.0.12-amzn
# sdk install gradle
# sdk install maven
# nvm install 22.5.1

# # Install Kafka
# wget https://downloads.apache.org/kafka/$KAFKA_VERSION/kafka_2.13-$KAFKA_VERSION.tgz
# tar -zxvf kafka_2.13-$KAFKA_VERSION.tgz
# rm kafka_2.13-$KAFKA_VERSION.tgz
# echo "export KAFKA_HOME=$KAFKA_DIR" >> ~/.bashrc
# echo "export PATH=\$PATH:$KAFKA_DIR/bin" >> ~/.bashrc
# source ~/.bashrc

# # Start Zookeeper
# echo "Starting Zookeeper..."
# nohup $KAFKA_DIR/bin/zookeeper-server-start.sh $KAFKA_DIR/config/zookeeper.properties > $LOG_DIR/zookeeper.log 2>&1 &
# timeout 10s tail -f $LOG_DIR/zookeeper.log || { echo "Zookeeper failed to start"; exit 1; }

# # Start Kafka
# echo "Starting Kafka..."
# nohup $KAFKA_DIR/bin/kafka-server-start.sh $KAFKA_DIR/config/server.properties > $LOG_DIR/kafka.log 2>&1 &
# timeout 10s tail -f $LOG_DIR/kafka.log || { echo "Kafka failed to start"; exit 1; }

# # Source environment variables
# source .env

# # Download and start Audit component
# if [ ! -f "audit.jar" ]; then
#     echo "audit.jar does not exist. Downloading..."
#     gsutil cp $GS_BUCKET/foundation-component-audit-0.0.1-SNAPSHOT.jar audit.jar || { echo "Failed to download audit.jar"; exit 1; }
# fi
# echo "Starting Audit component..."
# nohup /root/.sdkman/candidates/java/17.0.12-amzn/bin/java -jar audit.jar > $LOG_DIR/audit.log 2>&1 &
# timeout 10s tail -f $LOG_DIR/audit.log || { echo "Audit component failed to start"; exit 1; }

# # Download and start Scheduler component
# if [ ! -f "scheduler.jar" ]; then
#     echo "scheduler.jar does not exist. Downloading..."
#     gsutil cp $GS_BUCKET/foundation-component-scheduler-0.0.1-SNAPSHOT.jar scheduler.jar || { echo "Failed to download scheduler.jar"; exit 1; }
# fi
# echo "Starting Scheduler component..."
# nohup /root/.sdkman/candidates/java/17.0.12-amzn/bin/java -jar scheduler.jar > $LOG_DIR/scheduler.log 2>&1 &
# timeout 10s tail -f $LOG_DIR/scheduler.log || { echo "Scheduler component failed to start"; exit 1; }

# # Download and start UI Backend API
# if [ ! -f "ui-backend.jar" ]; then
#     echo "ui-backend.jar does not exist. Downloading..."
#     gsutil cp $GS_BUCKET/foundation-api-1.0.0.jar ui-backend.jar || { echo "Failed to download ui-backend.jar"; exit 1; }
# fi
# echo "Starting UI Backend API..."
# nohup /root/.sdkman/candidates/java/11.0.24-amzn/bin/java -jar ui-backend.jar > $LOG_DIR/ui-backend.log 2>&1 &
# timeout 10s tail -f $LOG_DIR/ui-backend.log || { echo "UI Backend API failed to start"; exit 1; }

# # Install and start lighttpd
# echo "Starting UI..."
# if ! dpkg -l | grep -q lighttpd; then
#     echo "lighttpd is not installed. Installing..."
#     sudo apt update
#     sudo apt install -y lighttpd || { echo "Failed to install lighttpd"; exit 1; }
# fi

# if ! systemctl is-active --quiet lighttpd; then
#     echo "lighttpd is not running. Starting..."
#     sudo systemctl start lighttpd || { echo "Failed to start lighttpd"; exit 1; }
# fi

# # Setup UI files
# sudo rm -Rf /var/www/localhost/htdocs
# sudo mkdir -p /var/www/localhost/htdocs
# gsutil cp $GS_BUCKET/dist.tar /tmp/ui.tar || { echo "Failed to download UI tarball"; exit 1; }
# sudo tar -xvf /tmp/ui.tar -C /var/www/localhost/htdocs || { echo "Failed to extract UI tarball"; exit 1; }
# gsutil cp $GS_BUCKET/lighttpd.conf /tmp/lighttpd.conf || { echo "Failed to download lighttpd.conf"; exit 1; }
# sudo cp /tmp/lighttpd.conf /etc/lighttpd/lighttpd.conf || { echo "Failed to copy lighttpd.conf"; exit 1; }
# sudo systemctl restart lighttpd || { echo "Failed to restart lighttpd"; exit 1; }
# timeout 10s sudo systemctl status lighttpd || { echo "lighttpd is not running"; exit 1; }


  EOF
}