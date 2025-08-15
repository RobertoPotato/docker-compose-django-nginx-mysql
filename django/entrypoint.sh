#!/bin/sh
set -e

echo "Waiting for db..."
while ! nc -z db 3306; do
  sleep 1
done
echo "Database ready."

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

exec "$@"
