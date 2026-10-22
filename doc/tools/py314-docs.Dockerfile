# ✦ 3.14.8 matches the GitHub ubuntu-24.04 runner image 20261012.334 toolcache.
# The official python images ship pip without setuptools since 3.12, so
# pkg_resources is absent here too.
FROM python:3.14.8-slim-trixie@sha256:fbecd461fc72d21b2143c6eaba25143738079154a6d0ea3da3aec724f50eed4a

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
