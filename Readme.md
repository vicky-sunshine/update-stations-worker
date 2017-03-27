# Update-station-worker

Use [Iron Worker](https://www.iron.io/platform/ironworker/) to update the [Ubike API Server server](https://github.com/vicky-sunshine/ubike).

## Configuration

#### Iron worker credential
After cloning this project, download `iron.json` from Iron Worker and place it in this directory.

#### Ubike API credential
Please copy the `config/config_env.json.example`
```shell
cp config/config_env.json.example config/config_env.json
```
Then, fill the `ACCOUNT` and `PASSWORD` in the `config_env.json`. ( These two fields should be the same as what you filled in the Ubike API Server project)

## Test worker in local
```shell
docker run -e "PAYLOAD_FILE"="./config/config_env.json" --rm -it -v "$PWD":/worker -w /worker lch82327/ruby-http:0.0.7
```
## Use Iron Worker
#### Package your code
```
zip -r update_ubike_stations.zip .
```
#### Upload your code
```
iron worker upload --zip update_ubike_stations.zip --name update_ubike_stations lch82327/ruby-http:0.0.7 ruby update_ubike_stations.rb
```
#### Queue tasks for your worker ( run it once )
```
iron worker queue --payload-file ./config/config_env.json --wait update_ubike_stations
```
If you want to schedule your worker, you have to go on the website for further settings.


## Docker
If you want to customize the docker, you can modify the `Dockerfile`.

Build Docker
```
docker build --rm --force-rm -t {username}/{image_name}:{tag} .
```
Push Docker
```
docker push {username}/{image_name}:{tag}
```
