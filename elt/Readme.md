# EL Workflow

This project sets up an Extract & Load (EL) workflow using Docker and PostgreSQL. The workflow extracts data from a source PostgreSQL database and loads it into a destination PostgreSQL database. This is done without any transformations, simply moving data between the two databases.

## How It Works:

- A ```source_postgres``` container is created and configured with a database named ```source_db```.

- A custom SQL initialization script (```init.sql```) is mounted to the container and executed automatically upon startup. This script inserts sample data into the ```source_db``` database.

- Another PostgreSQL container is created, this time configured with a database named ```destination_db```.

- The EL script (elt_script.py) is a Python script located in the ```elt``` folder, which is built into a Docker container which connects to both PostgreSQL databases using connection parameters defined in the Docker Compose file.

- The script’s purpose is to extract data from the ```source_postgres``` container (from ```source_db```) and load it into the ```destination_postgres``` container (into ```destination_db```).

- The container automatically waits for the ```source_postgres``` and ```destination_postgres``` containers to be ready before executing the Python script to perform the extraction and loading process because of the "depends_on" directive.

- The process is triggered automatically when the ```elt_script``` container starts and completes the data load once it has finished processing.

- All services (source and destination databases, as well as the EL script) are connected to a Docker network (```elt_network```) for seamless communication.

Inspired from freeCodeCamp.org!