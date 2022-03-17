FROM haproxy:1.8.19
COPY ./cron.d/ocsp_update /etc/cron.d/ocsp_update
RUN chmod 755 /etc/cron.d/ocsp_update
RUN chown root: /etc/cron.d/ocsp_update
