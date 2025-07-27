FROM busybox as base

RUN touch $(date +%Y-%m-%d-%H:%M:%S).txt

FROM base as app1

FROM base as app2

FROM base as app3
