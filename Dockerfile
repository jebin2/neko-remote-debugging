# Installs Chrome browser and socat (network proxy tool)
# ADDED: socat package for creating network proxy to solve Chrome's localhost-only binding
ARG BASE_IMAGE=ghcr.io/m1k1o/neko/base:latest
FROM $BASE_IMAGE

ARG SRC_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

RUN set -eux; \
    apt-get update; \
    wget -O /tmp/google-chrome.deb "${SRC_URL}"; \
    apt-get install -y --no-install-recommends openbox socat /tmp/google-chrome.deb; \
    # Clean up
    apt-get clean -y; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Copy configuration files
COPY supervisord.conf /etc/neko/supervisord/google-chrome.conf
COPY --chown=neko preferences.json /home/neko/.config/google-chrome/Default/Preferences
COPY policies.json /etc/opt/chrome/policies/managed/policies.json
COPY openbox.xml /etc/neko/openbox.xml