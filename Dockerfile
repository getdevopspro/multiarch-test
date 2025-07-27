FROM busybox

RUN touch $(date +%Y-%m-%d-%H:%M:%S).txt
