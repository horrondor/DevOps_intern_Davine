# ---- Build stage ----

FROM node:22-alpine AS builder

WORKDIR /app

RUN apk update && apk upgrade --no-cache

COPY package*.json ./

RUN npm ci

COPY . .

# Pass API URL into React build
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

RUN npm run build

# ---- Runtime stage ----
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html



EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]