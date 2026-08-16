import os
from pathlib import Path
from urllib.parse import urlparse

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = "dev-secret-key"
DEBUG = True
ALLOWED_HOSTS = ["*"]

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "rest_framework",
    "corsheaders",
]

MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]

ROOT_URLCONF = "config.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    }
]

WSGI_APPLICATION = "config.wsgi.application"


def _database_config_from_url(database_url: str) -> dict:
    parsed = urlparse(database_url)
    return {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": parsed.path.lstrip("/") or "coffee_chatbot_development",
        "USER": parsed.username or "app",
        "PASSWORD": parsed.password or "app_password",
        "HOST": parsed.hostname or "db",
        "PORT": parsed.port or 5432,
    }


def _database_config_from_env(prefix: str = "DB") -> dict:
    return {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": os.getenv(f"{prefix}_NAME", "coffee_chatbot_development"),
        "USER": os.getenv(f"{prefix}_USER", "app"),
        "PASSWORD": os.getenv(f"{prefix}_PASSWORD", "app_password"),
        "HOST": os.getenv(f"{prefix}_HOST", "db"),
        "PORT": os.getenv(f"{prefix}_PORT", "5432"),
    }


database_url = os.getenv("DB_CONNECTION_STRING") or os.getenv("DATABASE_URL")

DATABASES = {
    "default": _database_config_from_url(database_url)
    if database_url
    else _database_config_from_env(),
}

LANGUAGE_CODE = "es-ar"
TIME_ZONE = "America/Argentina/Buenos_Aires"
USE_I18N = True
USE_TZ = True
STATIC_URL = "static/"
DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"
CORS_ALLOW_ALL_ORIGINS = True
