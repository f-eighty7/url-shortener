# URL Shortener

A URL shortening service built with Python Flask and PostgreSQL. Paste a long URL, get a short code back, share it — anyone who visits the short link gets redirected to the original.

## How it works

```
POST /shorten   { url: "https://very-long-url.com" }  →  returns "sho.rt/abc123"
GET  /abc123                                          →  302 redirect to https://very-long-url.com
```

## Run locally with Docker Compose

**1. Clone the repo**
```bash
git clone https://github.com/f-eighty7/url-shortener.git
cd url-shortener
```

**2. Create a `.env` file**
```
DATABASE_URL=postgresql://user:password@db:5432/urlshortener
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

**3. Start the app**
```bash
docker compose -f docker-compose.dev.yml up --build
```

Visit `http://localhost:5000`

## Project structure

```
src/
├── app.py          # Flask routes
├── models.py       # SQLAlchemy model
└── templates/
    └── index.html  # HTML form
Dockerfile.dev
docker-compose.dev.yml
requirements.txt
```

## Stack

- **Flask** — web framework
- **PostgreSQL** — stores short code → long URL pairs
- **Flask-SQLAlchemy** — ORM layer between Flask and Postgres
- **Docker + Docker Compose** — containerised local development
- **Gunicorn** — production WSGI server (coming in production Dockerfile)

## Roadmap

- [x] Flask app with PostgreSQL
- [x] Docker + Docker Compose setup
- [ ] CI/CD with GitHub Actions
- [ ] AWS infrastructure with Terraform (VPC, EC2, RDS)
- [ ] Kubernetes deployment
- [ ] Prometheus + Grafana monitoring
