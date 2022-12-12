FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=rBwiY3JgqmG26q@

COPY setup.sql setup.sql
COPY import.sh import.sh
COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh
RUN chmod +x import.sh

CMD /bin/bash ./entrypoint.sh
