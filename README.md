# Resources

Ports:

- 17500 - communication port, TCP;

Volumes:

- /root/Dropbox/ - default share folder location;

# Check dropbox status

```sh
docker exec dropbox dropbox status
```

# Update dropbox inside container

```sh
docker exec -it dropbox /root/update-dropbox.sh && systemctl restart dropbox.service
```

# Update image

```sh
systemctl stop dropbox.service

docker rm dropbox

docker rmi softvisio/dropbox:latest

docker pull softvisio/dropbox:latest

# create container
docker create \
    --name dropbox \
    -h $(hostname) \
    -v /var/local/dropbox/:/root/Dropbox/ \
    -p 17500:17500 \
    --entrypoint /root/.dropbox-dist/dropboxd \
    softvisio/dropbox:latest

systemctl start dropbox.service

sleep 5

docker logs dropbox
```

# Install service

```sh
cat <<EOF > /etc/systemd/system/dropbox.service
[Unit]
Description=Dropbox service
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/local/bin/docker start -a dropbox
ExecStop=/usr/local/bin/docker stop dropbox

[Install]
WantedBy=multi-user.target
EOF

chmod +x /etc/systemd/system/dropbox.service

systemctl enable dropbox.service
```
