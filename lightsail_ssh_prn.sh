#!/usr/bin/env bash
ssh -i /Users/sandordeli/Projects/ssh/LightsailDefaultKey-eu-central-1.pem bitnami@3.64.149.130

# upload file
# scp -i /Users/sandordeli/Projects/ssh/LightsailDefaultKey-eu-central-1.pem /Users/sandordeli/Downloads/027f10ee1d4294f263ea6729437e7eb1.html bitnami@3.64.149.130:/home/bitnami/027f10ee1d4294f263ea6729437e7eb1.html