#!/bin/bash

DOMAIN=${1:-localhost.kubefire.com}

sudo certbot certonly --manual --preferred-challenges dns --manual-auth-hook ./auth.sh --manual-cleanup-hook ./cleanup.sh --domains $DOMAIN

