# Dockerfile
FROM python:3.10.4
RUN apt-get update && apt-get install -y imagemagick ffmpeg procps

RUN pip install --upgrade pip

WORKDIR /home/app

COPY requirements.txt requirements.txt
COPY  . .
RUN pip install -r requirements.txt

WORKDIR /home/app/Backend

CMD ["python", "main.py"]