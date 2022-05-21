# Arma Reforger Dedicated Server

Runs SteamCMD to update and pull latest updates on launch/restart.

## Usage
Edit the `server-config.json` file to your liking: https://community.bistudio.com/wiki/Arma_Reforger:Server_Hosting#Configuration_File

Start server with:
```
    docker compose up -d
```

Server profile is saved in the `./profile` directory.

The max server FPS can be adjusted via the environment variable `MAX_FPS`. It can be changed in the `docker-compose.yml` file as well as the default server ports.