import pytest
from app import create_app
from models import db


# 1. The App Fixture: configures the app for testing
@pytest.fixture
def app():
    """Configure the Flask application specifically for testing."""
    app = create_app(database_url="sqlite:///:memory:", testing=True)

    yield app


@pytest.fixture
def db_fixture(app):
    """Setup and teardown temporary in-memory database tables for each test."""
    with app.app_context():
        db.create_all()  # Setup: Create tables

        yield db  # Pauses here, runs the test

        db.session.remove()  # Teardown: Clean up
        db.drop_all()


# 3. The Client Fixture: provides the virtual test browser
@pytest.fixture
def client(app):
    """Provide a virtual browser client to simulate HTTP requests."""
    return app.test_client()
