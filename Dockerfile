# Dockerfile
FROM python:3.10.4-slim-buster
RUN apt-get -y update && apt-get -y install ffmpeg imagemagick procps
RUN pip install --upgrade pip
# modify ImageMagick policy file so that Textclips work correctly.
RUN sed -i 's/none/read,write/g' /etc/ImageMagick-6/policy.xml 

WORKDIR /home/app

COPY requirements.txt requirements.txt
COPY  . .
RUN pip install -r requirements.txt

WORKDIR /home/app/Backend
CMD ["python", "main.py"]