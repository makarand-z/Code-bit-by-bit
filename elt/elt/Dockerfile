FROM python:3.8-slim

# Install required packages
RUN apt-get update && apt-get install -y curl ca-certificates gnupg && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt $(grep -oP '(?<=^VERSION_CODENAME=).*' /etc/os-release)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && apt-get install -y postgresql-client-17 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the script into the container
COPY elt_script.py .

# Set the command to run the script
CMD ["python", "elt_script.py"]
