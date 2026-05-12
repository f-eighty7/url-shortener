# URL Shortener

A URL shortening service built with Python Flask and PostgreSQL. Paste a long URL, get a short code back, share it — anyone who visits the short link gets redirected to the original.

## How it works

```
POST /shorten   { url: "https://very-long-url.com" }  →  returns "abc123"
GET  /abc123                                          →  302 redirect to https://very-long-url.com
```

## Run locally

**1. Start Postgres**
```bash
docker run -d \
  --name postgres \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=urlshortener \
  -p 5433:5432 \
  postgres:18
```

**2. Install dependencies**
```bash
python -m venv venv
source venv/bin/activate
pip install flask flask-sqlalchemy psycopg2-binary
```

**3. Run the app**
```bash
flask --app app run
```

**4. Test it**
```bash
# Shorten a URL
curl -X POST http://localhost:5000/shorten -d "url=https://google.com"
# Returns a short code e.g. "abc123"

# Follow the short link (open in browser or curl -L)
curl -L http://localhost:5000/abc123
```

## Stack

- **Flask** — web framework
- **PostgreSQL** — stores short code → long URL pairs
- **Flask-SQLAlchemy** — ORM layer between Flask and Postgres
- **Docker** — runs Postgres locally

## Roadmap

- [ ] CI/CD with GitHub Actions
- [ ] AWS infrastructure with Terraform (VPC, EC2, RDS)
- [ ] Kubernetes deployment
- [ ] Prometheus + Grafana monitoring
