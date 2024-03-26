FROM python:3.9
COPY ./giropops-senhas /app
WORKDIR /app
RUN pip install --no-cache-dir -r /app/requirements.txt
EXPOSE 5000
ENV REDIS_HOST=172.17.0.2
ENV FLASK_APP=app.py
ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
