# Use the ubuntu/python:latest image as the base
FROM python:latest

# Set the working directory in the container
WORKDIR /app

# Update the package list
RUN apt update

# Install wget
RUN apt install wget unzip -y

# Install ngrok
RUN  curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && apt update && apt install ngrok

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the rest of your application's code
COPY . /app

# Make shell script executable
RUN chmod +x start.sh

# Expose flask ports
EXPOSE 8500

# Run app.py when the container launches
CMD ["./start.sh"]