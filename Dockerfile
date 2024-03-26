FROM alpine:3.19.1
COPY ./giropops-senhas /app
WORKDIR /app
RUN apk update && apk add py3-pip && pip install --no-cache-dir -r /app/requirements.txt --break-system-packages
ENV REDIS_HOST=172.17.0.2
ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
