# Day 2 - Challenge 2 - LINUXtips-Giropops-Senhas

This repositoy contain the project files to implement an application using a Dockerfile.
The challenge is create a Dockerfile that has all the requirements.

## Running the application locally

Clone the repository:
`git clone https://github.com/badtuxx/giropops-senhas.git`

Select the folder:
`cd giropops-senhas/`

System update:
`apt-get update`

Install pip:
`apt-get install pip`

Install the dependences:
`pip install --no-cache-dir -r requirements.txt`

Install redis that will be used by application:
`apt-get install redis`

Start redis:
`systemctl start redis`

Create the variable for redis:
`export REDIS_HOST=localhost`

Start the application:
`flask run --host=0.0.0.0`

With the previously instructions to run the application locally, it is possible construct a Dockerfile to implement the containerized application.

## Creating Dockerfile

Guide:

- Create a Docker Hub account
- Create a Github account
- Criate a Dockerfile for the application
- The name of the image must be [login from dockerhub]/[linuxtips-giropops-senhas:1.0]
- Push image to Docker hub, public
- Create a public repository calls LINUXtips-Giropops-Senhas
- Push the code and the Dockerfile
- Create the container using the image created
- The name of the container must be giropops-senhas
- The container need to be running
- Redis must be a container
- We need the variable REDIS_HOST enabled

To supply all the requirements of the application we can use an based image python:
```
FROM python:3.9
COPY ./giropops-senhas /app
WORKDIR /app
RUN pip install --no-cache-dir -r /app/requirements.txt
EXPOSE 5000
ENV REDIS_HOST=172.17.0.2
ENV FLASK_APP=app.py
ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]
```

## Creating the image

Creating the image locally:

`docker login`

`docker image build -t stheferri/linuxtips-giropops-senhas:1.0 .`

Push the image to Dockerhub:

`docker push stheferri/linuxtips-giropops-senhas:1.0`

## Creating the container

Creating and running the container:

`docker container run -d -p 5000:5000 --name giropops-senhas stheferri/linuxtips-giropops-senhas:1.0`

## Result

Accessing `localhost:5000` the application it is running:


![result](https://github.com/stheferrix/LINUXtips-Giropops-Senhas/blob/main/password-generator.PNG "password-generator.PNG")

# Tips

- Around the challenge I found many errors while trying running the application locally and through container.
Essentialy the errors to run the application can solve changing the version of flash in requirements file and adding `werkzeug` to requirements too. The hole explanation of the solution can be check here: https://stackoverflow.com/questions/77213053/why-did-flask-start-failing-with-importerror-cannot-import-name-url-quote-fr

- For redis must be a aparted container it is not necessary create a customize image, you can use the latest version of redis image available here: https://hub.docker.com/_/redis without customization. Try to inspect the container running to get the ip address of the container because will be used on Dockerfile by the application `ENV REDIS_HOST=172.17.0.2`.

- The application will run over the port:5000. You need to expose the port in Dockerfile previously but you need also in the moment of the container running map the port of host and the port of container, I mean the port of the host 5000 port will be pass all the connections to the 5000 port for the container: 

> docker container run -d **-p 5000:5000** --name giropops-senhas stheferri/linuxtips-giropops-senhas:1.0

