# syntax=docker/dockerfile:1
#
# Copyright 2024 Nialto Services Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM golang:1.23-alpine3.20 AS build

WORKDIR /usr/src/app

COPY dovecot-xaps-daemon .
RUN go build -o /usr/local/bin/xapsd ./cmd/xapsd/xapsd.go

FROM alpine:3.20

LABEL org.opencontainers.image.description="Dovecot Apple Push Service Daemon"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.source="https://github.com/NialtoServices/docker-xapsd"

COPY --from=build /usr/local/bin/xapsd /usr/local/bin/xapsd

ENTRYPOINT ["/usr/local/bin/xapsd"]
