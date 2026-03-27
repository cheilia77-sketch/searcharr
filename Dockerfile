FROM python:3.11-slim

LABEL Name=Searcharr Version=2.0.0

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt ./
RUN python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt

COPY . /app

CMD ["python3", "searcharr.py"]
