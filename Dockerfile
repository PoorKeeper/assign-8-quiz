# Step 1: Choose a base image
# Hint: search https://hub.docker.com for an official Python image.
# Use a specific version tag (e.g. python:3.11-slim) — avoid 'latest'.
FROM python:3.11-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements file into the container
# Why copy this BEFORE the rest of the code?
COPY requirements.txt ./

# Step 4: Install Python dependencies
# Hint: use pip install with the -r flag and add --no-cache-dir to keep the image small
RUN pip install -r requirements.txt --no-cache-dir

# Step 5: Copy the rest of the application source code
COPY . .

RUN python -c "import db; db.init_db()" 
# Step 6: Expose the port the app listens on
# Hint: check app.py to find the port number
# EXPOSE 5000
ENV PORT=5000

# Step 7: Set the command to start the application
# Hint: the entry point is app.py
# CMD ["python", "app.py"]
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:$PORT --workers 2 app:app"]
