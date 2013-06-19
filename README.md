## Hush

A shameless rip off of one time secret

## Client

### Create a new secret
```shell
$ curl -X POST -d "my_secret_string0928348#(*&$@(#*$))" https://hush.example.com/secrets
2384289372342-=98234987239487
```

### To read it back
```shell
$ curl https://hush.example.com/secrets/2384289372342-=98234987239487
my_secret_string0928348#(*&$@(#*$))
```
