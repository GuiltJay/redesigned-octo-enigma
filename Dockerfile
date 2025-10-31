# Use an official lightweight Python image
FROM python:3.11-slim

# Prevent Python from buffering logs
ENV PYTHONUNBUFFERED=1

# Install system dependencies required by Chromium
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk-bridge2.0-0 \
    libxkbcommon0 \
    libgtk-3-0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libcups2 \
    libdrm2 \
    libxshmfence1 \
    libglu1-mesa \
    wget \
    fonts-liberation \
    libappindicator3-1 \
    libatk1.0-0 \
    libatk-adaptor \
    libpango-1.0-0 \
    libx11-xcb1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxtst6 \
    libxcb1 \
    libglib2.0-0 \
    libxrender1 \
    libdbus-glib-1-2 \
    libgdk-pixbuf2.0-0 \
    libxcb-shm0 \
    libgstreamer-gl1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    libgstreamer1.0-0 \
    libjpeg-dev \
    libpng-dev \
    libxss1 \
    libxt6 \
    libgbm-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy project
WORKDIR /app
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt && playwright install chromium

# Expose port
EXPOSE 8000

# Start app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
