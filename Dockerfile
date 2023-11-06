FROM eclipse-temurin:11-alpine AS builder
RUN apk add --no-cache maven npm
WORKDIR /src
RUN npm install react-dom react-dropzone react-scripts
COPY . .
RUN ./build.sh

FROM eclipse-temurin:11-alpine
LABEL description="Pa(tch)Se(arch) is an experimental search engine for code allowing search by patch."
LABEL version="0.1"
WORKDIR /opt/pase
COPY --from=builder /src/target/pase-*.jar pase.jar
ENTRYPOINT ["java", "-jar", "pase.jar"]
