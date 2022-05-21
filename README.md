# Arma Reforger Dedicated Server

Runs SteamCMD to update and pull latest updates on launch/restart.

## Usage
Edit the `server-config.json` file to your liking: https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting#Configuration_File

Start server with:
```
    docker compose up -d
```

Server profile is saved in the `./profile` directory.

The max server FPS can be adjusted via the environment variable `MAX_FPS`.

Example `docker-compose.yml`:
```yaml
version: "3.7"
services:
  server:
    image: knappster/arma-reforger-server:latest
    restart: unless-stopped
    user: "1000:1000"
    environment:
      MAX_FPS: 60
    ports:
      - "2001:2001/udp"
      - "17777:17777/udp"
      - "1376:1376/tcp"
    volumes:
      - app_data:/home/steam/app_data
      - ./server-config.json:/home/steam/server-config.json
      - ./profile:/home/steam/profile

volumes:
  app_data:
    driver: local
```