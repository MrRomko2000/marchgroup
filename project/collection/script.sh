#!/bin/bash

# Set your Ansible Galaxy login and API key
GALAXY_LOGIN="marchgroup2023"
API_KEY="c691db3bf95da15d1cdb226cc32e229bd5618569"

# Set the collection name, version, and tarball filename
COLLECTION_NAME="project"
COLLECTION_VERSION="1.0.0"
TARBALL_FILENAME="project-collection-${COLLECTION_VERSION}.tar.gz"

# Build the collection tarball
ansible-galaxy collection build --force --output-path=./

# Check if the tarball was created successfully
if [ -f "${TARBALL_FILENAME}" ]; then
  echo "Collection tarball created successfully: ${TARBALL_FILENAME}"
else
  echo "Failed to create collection tarball"
  exit 1
fi

# Login to Ansible Galaxy
ansible-galaxy login --token "${API_KEY}"

# Publish the collection to Ansible Galaxy
ansible-galaxy collection publish --token "${API_KEY}" "${TARBALL_FILENAME}" -r marchgroup

# Check if the publishing was successful
if [ $? -eq 0 ]; then
  echo "Collection published successfully to Ansible Galaxy"
else
  echo "Failed to publish collection to Ansible Galaxy"
  exit 1
fi

