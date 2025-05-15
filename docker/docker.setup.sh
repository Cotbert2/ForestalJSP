docker run -d \
  --name postgres_web \
  -e POSTGRES_USER=forestal_tree \
  -e POSTGRES_PASSWORD=admin123 \
  -e POSTGRES_DB=forestal \
  -p 5432:5432 \
  postgres:15