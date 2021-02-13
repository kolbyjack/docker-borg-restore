FROM alpine:latest

RUN apk --no-cache add bash borgbackup curl openssh-client

COPY restore.sh /sbin/restore.sh
RUN chmod +x /sbin/restore.sh

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]

HEALTHCHECK CMD test ! -f /tmp/restore_failed

