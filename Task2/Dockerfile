# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies specified in requirements.txt
# If your app has additional dependencies, list them in a requirements.txt file
# RUN pip install --no-cache-dir -r requirements.txt

# Set environment variable for the application
ENV MY_ENV_VAR="World"

# Run app.py when the container launches
CMD ["python", "app.py"]
