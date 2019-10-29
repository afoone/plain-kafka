# plain-kafka
Plain kafka image

## docker compose

```
$ docker network create kafka

$ docker compose up -d
Creating plain-kafka_zookeeper_1 ... done
Creating plain-kafka_broker_1    ... done
Creating plain-kafka_zkui_1      ... done
$
```


## docker-swarm

```
$ docker stack deploy --compose-file docker-stack.yml kafka
Creating network kafka_default
Creating service kafka_zkui
Creating service kafka_broker
Creating service kafka_zookeeper
$
```

![](pics/kafka_zkui.png)
