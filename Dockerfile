FROM ubuntu:18.04 as stage1 
RUN  apt-get update && apt-get install -y toilet && rm -rf var/lib/apt/lists/* 
ENTRYPOINT ["toilet", "-F", "border","--gay"] 
CMD ["Hello world"]



