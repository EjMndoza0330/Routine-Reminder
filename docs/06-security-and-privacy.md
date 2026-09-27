# Security and privacy

This repository is public. Fill this in honestly and date it; it is checked as
part of grading.

**Last checked:** 2026-09-27

## What this app stores

| Data | Where it lives | Who can see it |
| --- | --- | --- |
| The user's task list, daily progress, and streak counter | on the device (`shared_preferences`) | only that user |

## Secrets

- Values my app needs at run time: None. The app operates completely locally.
- Where they live locally: N/A. No `.env` or configuration file is required.
- Where the deploy workflow gets them: N/A. No GitHub Actions secrets are needed.
- Anything my deployed web build carries that a visitor could read, and why that is acceptable: Nothing. There are no API keys, cloud databases, or backend configs shipped with this web build.

## What protects the data on the service side

- Nothing leaves the device. All task and streak data is strictly managed locally on the user's hardware.

## Checklist

- [x] `.env` (or `env.json`) is in `.gitignore`, and `.env.example` is committed *(N/A - no environment variables used)*
- [x] `git log -p | grep -i "api_key\|secret\|password\|token"` finds nothing real
- [x] No service account file, keystore or `service_role` key anywhere in the repo
- [x] Security rules or RLS policies written and tested, not left open *(N/A - no cloud database used)*
- [x] No real personal data in sample data, screenshots or the video
- [x] No course or university credentials anywhere
- [x] Anyone whose data appears in a test was asked first

I found no leaked credentials because the app is entirely local, meaning no secret keys were ever required or committed.
