#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit 1
for py in 314 315; do
	if docker build --no-cache -f tools/py$py-docs.Dockerfile --build-arg GOOGLEANALYTICS_SPEC='==0.5' .; then echo "UNEXPECTED: py$py 0.5 built"; else echo "EXPECTED: py$py 0.5 failed"; fi
	if docker build --no-cache -f tools/py$py-docs.Dockerfile .; then echo "EXPECTED: py$py pinned built"; else echo "UNEXPECTED: py$py pinned failed"; fi
done
