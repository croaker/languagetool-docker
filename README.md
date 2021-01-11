# Languagetool Docker

Dockerfile contains instructions to build a preconfigured image of the 
[languagetool http server](http://wiki.languagetool.org/http-server).

# How To Use

```
docker build -t languagetool .
docker run -d -p 8081:8081 languagetool:latest
```

# Credits

The Dockerfile is based on
[gentics/languagetool-docker](https://github.com/gentics/languagetool-docker).
Thanks for sharing!
