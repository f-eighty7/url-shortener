# URL Shortener

A simple website to shorten long URLs (like bit.ly). Paste a long link, get a short link, and share it. Anyone who clicks the short link gets automatically redirected to your original long website.

## How it works

```text
POST /shorten   { url: "https://very-long-url.com" }  →  returns "http://localhost:5000/abc123"
GET  /abc123                                          →  Redirects to https://very-long-url.com
```

---

## Run Locally with Docker Compose

**1. Clone the repository**
```bash
git clone https://github.com/f-eighty7/url-shortener.git
cd url-shortener
```

**2. Create a `.env` file**
Create a file named `.env` in the main folder and write this inside:
```env
DATABASE_URL=postgresql://user:password@db:5432/urlshortener
POSTGRES_USER=user
POSTGRES_PASSWORD=password
```

**3. Start the application**
```bash
docker compose -f docker-compose.dev.yml up --build
```
Open your browser and visit: `http://localhost:5000`

---

## Run Automated Tests & Coverage

The automated tests can be run locally inside your virtual environment. The test suite uses a fast, temporary SQLite database in-memory so it does not affect real development or database data.

**1. Create a Python virtual environment & install dependencies**
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**2. Run the tests with coverage reporting**
```bash
venv/bin/pytest -v --cov=src --cov-report=xml --cov-report=html
```
*(This generates a standard `coverage.xml` report and an interactive `htmlcov/` folder. Open `htmlcov/index.html` in your browser to inspect line-by-line coverage!).*

---

## Project Structure

```text
src/
├── app.py          # Flask routes (Application Factory)
├── models.py       # SQLAlchemy Database Model (Link)
└── templates/
    └── index.html  # HTML Form page
tests/
├── conftest.py     # Setup helpers for Pytest (App, Database, Client)
└── test_routes.py  # 4 test cases (Homepage, Shorten, Redirect, 404 Error)
Dockerfile.dev      # Dockerfile for local development
docker-compose.dev.yml # Docker Compose file for development
pytest.ini          # Pytest path configurations
requirements.txt    # Project dependencies
```

---

## Technologies Used

*   **Flask** — Web framework
*   **PostgreSQL** — Relational database
*   **Flask-SQLAlchemy** — ORM database tool
*   **Pytest** — Automated testing tool
*   **SQLite** — Temporary test database
*   **Docker & Docker Compose** — Container tools

---

## Roadmap

*   [x] Flask app with PostgreSQL database
*   [x] Docker & Docker Compose setup
*   [x] Automated tests with Pytest & SQLite
*   [x] CI/CD with GitHub Actions
*   [x] AWS cloud deployment with Terraform (VPC, EC2, RDS)
*   [ ] Production-grade Docker (Multi-stage build, Gunicorn WSGI, non-root user)
*   [ ] Modular Terraform (Dev/Prod directories, remote S3/DynamoDB backend)
*   [ ] DevSecOps Pipeline (Secret scanning with TruffleHog, Docker scanning with Trivy, IaC scanning with Tfsec)
*   [ ] Kubernetes deployment (Local Minikube / EKS)
*   [ ] Prometheus & Grafana monitoring
