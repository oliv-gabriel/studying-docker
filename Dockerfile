FROM python:3.9-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 8080
COPY . .
CMD ["python3", "app.py"]
