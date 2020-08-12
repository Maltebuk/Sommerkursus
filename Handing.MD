# Handin

## Opgave 1. 

Link til Docker filen: 
https://hub.docker.com/repository/docker/maltebuk/toilet

Hvad kan man gøre for at

1. Minimere lagene i imaget
For at minimere lagene skal man undgå at bruge mange run copy og add funkioner da de allesamme opretter lag Ref:(https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
Man kan begrænse brugen af disse ved at flette statementet sammen så mange ting bliver løst på samme kommando ligesom det kan ses her :RUN  apt-get update && apt-get install -y toilet && rm -rf var/lib/apt/lists/*

Slutteligt kan man minimere lag ved at bruge multistage builds som giver muligheden for at man kun kopiere de artifakter med til det endelige byg. 

2. Minimere størrelsen på image
 
maltebuk/toilet                       68.1MB - Komprimeret

firsttry                              97.3MB - Den på docker

Hvis man gerne vil minimere image størrelsen, man man sørge for at man rydder op i lists dir. Derefter går størrelsen fra ca 47

FROM ubuntu:18.04 as stage1
RUN  apt-get update && apt-get install -y toilet && rm -rf var/lib/apt/lists/*
ENTRYPOINT ["toilet", "-F", "border","--gay"]
CMD ["Hello world"]

Denne reduktion kommer af at man bruger  rm -rf var/lib/apt/lists/* til at rydde op. 
hvis man gerne vil have den endnu mindre kan man begynde at udarbejde funktionaliteten i scratch hvilket gør du selv skal holde styr på dine afhængigheder igennem systemet og har muligheden for at tage netop det med du skal bruge for at få dit program til at kører. Derved minimere du spild. 


## opgave 2.


Docker composefilen indeholder løsningen til de første delopgaver.

1. Hvordan sletter og opretter man containers
Hvis man gerne vil slette en container kan man gøre følgende
- docker container stop [container_id]
  - Derefter: docker container rm [container_id]
- Fjerner alle stoppede containers: docker container rm $(docker container ls –aq) 
- Fjerner alle containers: docker container stop $(docker container ls –aq) && docker system prune –af ––volumes
- Man kan oprette en container således: docker container create [OPTIONS] IMAGE [COMMAND] [ARG...]


2. Hvordan definere man den præcise version af mysql
Man kan definere den præcise version af Mysql efter " : "  hvori man kan sige om det skal være den nyeste (hvis man ikke skriver noget). Eller hvilken version man ønsker at containeren skal kørers med: 

 db:
     image: mysql:latest (her kan versionen indsættes)

     network:
      -network1
  loadbalancer-nginx:

3. hvilke kommandoer vil give dig Ipen fra dine kontainers i det beskrevne netværk

Man kan bruge følgende kommandoer til at finde Ip'en for sit netværk
- for at finde dit netværk kan denne bruges: docker network ls
- Derefter kan man finde informationen om det gældende net såleds: docker network inspect <Dit dockernetværks navn>


## opgave 3.
Chain of images for nextcloud er følgende: 

- 1. php:7.4-apache-buster 
- 2. debian:buster-slim
- 3. scratch
