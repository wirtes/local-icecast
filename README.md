# local-icecast

This project provides a Docker Compose setup for running an Icecast server that streams random tracks from a local music directory using a Liquidsoap source. Two mount points are provided: an MP3 stream and an AAC stream.

## Prerequisites

- Docker
- Docker Compose
- A collection of MP3 and/or AAC files placed in the `media/` directory (or adjust the path in the compose file)

## Files

- `docker-compose.yml` – Defines the Icecast and Liquidsoap services.
- `icecast/icecast.xml` – Icecast configuration that is mounted into the container.
- `liquidsoap/radio.liq` – Liquidsoap script that randomly plays music and sends it to Icecast.
- `media/` – Directory for your local music collection (add your own files).

## Usage

1. Copy your MP3 and AAC files into the `media/` directory. The directory is mounted read-only into the Liquidsoap container at `/music`.
2. (Optional) Update passwords, stream names, or metadata in `icecast/icecast.xml` and the environment variables defined for the Liquidsoap service inside `docker-compose.yml`.
3. Start the services:

   ```bash
   docker compose up -d
   ```

4. Access the Icecast status page at [http://localhost:8000](http://localhost:8000) to monitor the streams. The streams are exposed at:
   - `http://localhost:8000/stream.mp3`
   - `http://localhost:8000/stream.aac`

5. To stop the stack:

   ```bash
   docker compose down
   ```

### Notes

- The Icecast configuration, Liquidsoap script, and music library all reside outside of the containers, making the setup easy to back up and customize.
- Update the default passwords in `icecast/icecast.xml` and `docker-compose.yml` before exposing the service to untrusted networks.
