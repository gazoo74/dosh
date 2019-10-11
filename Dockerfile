FROM ubuntu:16.04
RUN apt-get update && apt-get install -y asciidoctor
RUN apt-get update && apt-get install -y docker.io
RUN apt-get update && apt-get install -y make fakeroot bash-completion
ADD dosh /usr/bin/
ADD bash-completion /usr/share/bash-completion/completions/dosh
ENTRYPOINT ["/bin/echo","Hello, world!"]
