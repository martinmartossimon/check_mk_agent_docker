FROM ubuntu

MAINTAINER martin.martos.trabajo@gmail.com

COPY plugins/ /tmp/plugins

RUN apt-get update -y && \
apt-get install -y --no-install-recommends xinetd jq curl wget && \
wget "http://172.18.170.100/PROD/check_mk/agents/check-mk-agent_1.4.0p31-1_all.deb" -O /tmp/check-mk-agent_1.4.0p31-1_all.deb && \
apt-get install -y /tmp/check-mk-agent_1.4.0p31-1_all.deb  && \
cp -r /tmp/plugins /usr/lib/check_mk_agent/


# Switch from 'connections per second' rate limiting, since it disables the
# service completely (potential DoS) to 'maximum instances of service per
# source IP address' limit. The limit is the same default as for 'cps' (50).
RUN \
  sed -i 's/^}$/cps = 0 0\nper_source = 50\n}/' /etc/xinetd.conf && \
  grep "cps = 0" /etc/xinetd.conf && \
  grep "per_source = 50" /etc/xinetd.conf && \
  nl /etc/xinetd.conf


ENTRYPOINT [ "xinetd", "-dontfork" ]

#EXPOSE 6556/tcp
