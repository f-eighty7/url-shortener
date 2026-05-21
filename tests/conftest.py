import pytest
from app import create_app
from models import db


# 1. The App Fixture: configures the app for testing
@pytest.fixture
def app():
    app = create_app(database_url="sqlite:///:memory:", testing=True)

    yield app


@pytest.fixture
def db_session(app):
    with app.app_context():
        db.create_all()  # Setup: Create tables

        yield db  # Pauses here, runs the test

        db.session.remove()  # Teardown: Clean up
        db.drop_all()


# 3. The Client Fixture: provides the virtual test browser
@pytest.fixture
def client(app):
    return app.test_client()
