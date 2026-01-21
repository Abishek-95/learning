FROM python:3.10-slim

WORKDIR /app

RUN pip install dbt-postgres==1.9.0

COPY . /app

CMD ["dbt", "debug"]
