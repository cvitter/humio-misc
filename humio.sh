# Simple script to start and stop Humio (plus Zookeeper and Kafka)  on a single node

echo "Attempting to $1 Humio..."
if [ "$1" = "start" ]; then
   # Start Zookeeper
   systemctl is-active --quiet zookeeper.service || sudo systemctl start zookeeper.service

   # Start Kafka
   systemctl is-active --quiet kafka.service || sudo systemctl start kafka.service

   # Start Humio
   systemctl is-active --quiet humio.service || sudo systemctl start humio.service

   echo "The Humio service is now running."
fi

if [ "$1" = "stop" ]; then
   # Stop Humio
   sudo systemctl stop humio.service
   systemctl is-active --quiet humio.service || echo "Humio has stopped running"

   # Stop Kafka
   sudo systemctl stop kafka.service
   systemctl is-active --quiet kafka.service || echo "Kafka has stopped running"

   # Stop Zookeeper
   sudo systemctl stop zookeeper.service
   systemctl is-active --quiet zookeeper.service || echo "Zookeeper has stopped running"

   echo "The Humio service is now stopped."
fi
