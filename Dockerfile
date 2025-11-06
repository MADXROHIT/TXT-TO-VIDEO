# ✅ Updated base image (buster → bookworm)
FROM python:3.10-slim-bookworm

# Install system dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app/
WORKDIR /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt
RUN pip install pytube

# Set environment variable
ENV COOKIES_FILE_PATH="youtube_cookies.txt"

# Run the app
CMD gunicorn app:app & python3 main.py
#spidy
