ARG VERSION=latest
FROM ethersphere/bee:$VERSION

COPY --chown=999:999 . .bee/
