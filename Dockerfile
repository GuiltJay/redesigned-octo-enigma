# Use Playwright base image — includes all browser deps preinstalled!
FROM mcr.microsoft.com/playwright/python:v1.48.0-jammy

# Disable buffer for logs
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# (Optional) Install Chromium if not already included
RUN playwright install --with-deps chromium

# Expose port
EXPOSE 8000

# Start FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
