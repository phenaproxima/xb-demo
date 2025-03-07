# Pre-release demo of Drupal Experience Builder

## ⚠️ WARNING ⚠️
This repository is intended to provide a **pre-beta demo** of Experience Builder. **Experience Builder is not stable** and could change anything, at any time, without warning. There is no update path yet; data loss is possible. Additionally, this demo project will be _abandoned_ when Experience Builder reaches beta (expected in mid-2025).

[Feedback is very welcome](https://www.drupal.org/node/add/project-issue/experience_builder), but **you ABSOLUTELY _SHOULD NOT_ use this project to build a real site.**

## About
Experience Builder (or XB for short) is Drupal's next-generation page building tool, [currently under heavy development on drupal.org](https://www.drupal.org/project/experience_builder). This is a demo package of Drupal to try out Experience Builder. 😎

## Getting Started 🚀
We strongly recommend using [DDEV](https://ddev.com/get-started/) (version 1.24.0 or later) to run this project, since it includes everything you'll need. Run the following commands to spin up with DDEV:
```shell
mkdir xb-demo
cd xb-demo
ddev config --project-type=drupal11 --docroot=web
ddev composer create phenaproxima/xb-demo --stability=dev
ddev launch
```
You don't _have_ to use DDEV; any tech stack that supports Drupal should work just fine.

## Getting Help
Questions? Feedback? Bugs? [Find us in the #experience-builder channel on Drupal Slack.](https://drupal.slack.com/archives/C072JMEPUS1)
