# ✦ The official python images ship pip without setuptools since 3.12, so
# pkg_resources is absent, as on the GitHub ubuntu-24.04 runner toolcache.
FROM python:3.15.0-slim-trixie@sha256:f5b92f2a669a4c347044f29367f31983280b648250ca94dea66f98c53bc87e58

ARG GOOGLEANALYTICS_SPEC=""

WORKDIR /doc
COPY requirements.txt .
RUN python -m pip install --no-cache-dir --root-user-action=ignore -r requirements.txt \
    && if [ -n "$GOOGLEANALYTICS_SPEC" ]; then \
        python -m pip install --no-cache-dir --root-user-action=ignore "sphinxcontrib-googleanalytics$GOOGLEANALYTICS_SPEC"; \
    fi \
    && python -m pip list

COPY source/ source/
RUN sphinx-build -j auto -b html source build
