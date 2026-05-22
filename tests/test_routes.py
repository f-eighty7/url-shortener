import pytest
from models import Link

URL = "https://www.google.se"


def test_home_page(client):
    """Test that the homepage loads successfully and contains the form."""
    response = client.get("/")
    assert response.status_code == 200
    assert b"submit" in response.data


def test_shorten_url(client, db_fixture):
    """Test that submitting a URL saves it to the database and shows success."""
    response = client.post("/shorten", data={"url": URL})
    assert response.status_code == 200
    assert b"Your short link" in response.data
    saved_link = Link.query.first()
    assert saved_link != None
    assert saved_link.long_url == URL


def test_redirect(client, db_fixture):
    """Test that a valid short code redirects to the original destination URL."""
    fake_link = Link(short_code="abc", long_url=URL)
    db_fixture.session.add(fake_link)
    db_fixture.session.commit()
    response = client.get("/abc")
    assert response.status_code == 302
    assert response.headers["Location"]


def test_404_not_found(client, db_fixture):
    """Test that a non-existent short code returns a 404 Not Found error."""
    response = client.get("/if_this_path_exists_something_is_wrong")
    assert response.status_code == 404
