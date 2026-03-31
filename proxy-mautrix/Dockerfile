FROM dock.mau.dev/mautrix/telegram:latest

RUN apk add iptables gost

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
