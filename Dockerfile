FROM barichello/godot-ci:4.5.1@sha256:ed732ef7d470463cbcfbcbdc721ad798fab5a576705bd76587ce824f2cb98e59 AS build

WORKDIR /src
COPY . .
RUN mkdir -p build/web \
    && godot --headless --path /src --import \
    && godot --headless --path /src --export-release Web /src/build/web/index.html

FROM nginx:1.27-alpine@sha256:62223d644fa234c3a1cc785ee14242ec47a77364226f1c811d2f669f96dc2ac8

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/build/web /usr/share/nginx/html

EXPOSE 4173
