FROM python:3.10-slim

WORKDIR /src

COPY . .

RUN pip install --no-cache-dir fastapi uvicorn mysql-connector-python

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
