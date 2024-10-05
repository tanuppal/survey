#!/bin/bash

# Define the image name
IMAGE_NAME="ruby_survey_app"

# Build the Docker image
echo "Building the Docker image..."
docker build -t $IMAGE_NAME .

# Check if the Docker build was successful
if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

# Run the Docker container
echo "Running the Docker container..."
docker run -it -v "$(pwd)/survey_data.pstore:/app/survey_data.pstore" $IMAGE_NAME

