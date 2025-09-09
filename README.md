# Pre-release demo of Drupal Canvas

<img src="https://github.com/user-attachments/assets/c7c3283b-2580-4434-8cce-771cb02aa1f7" width="300" align="right" />

Drupal Canvas (or Canvas for short) is Drupal's next-generation page building tool, [currently under heavy development on drupal.org](https://www.drupal.org/project/canvas). This is a demo package of Drupal to try out Drupal Canvas with a demo design system and sample pages. 😎

This repository is intended to provide a **throwaway demo** of Drupal Canvas. **Drupal Canvas is not yet stable** and could change anything, at any time, without warning. 

There is no update path yet; data loss is possible. Additionally, this demo project will be _abandoned_ when Drupal CMS includes sufficient functionality to supersede the demo. That is expected around DrupalCon Vienna in October 2025. 

**You ABSOLUTELY _SHOULD NOT_ use this project to build a real site.**

## This Is How the Demo Looks Like

<img width="1918" alt="Demo screenshot" src="https://github.com/user-attachments/assets/e974d6b1-11ba-4359-8321-8917b0778040" />

## Getting Started with the Demo 🚀

We strongly recommend using [DDEV](https://ddev.com/get-started/) (version 1.24.2 or later) to run this project, since it includes everything you'll need.

Cloning the repository locally is not required!

Instead, in a terminal with DDEV installed, run the following commands to spin it up:

```shell
mkdir xb-demo
cd xb-demo
ddev config --project-type=drupal11 --docroot=web

# For DDEV v1.24.2 or newer:
ddev composer create-project phenaproxima/xb-demo --stability=dev
# For DDEV v1.24.1 or older, upgrade DDEV or run this instead:
# ddev composer create phenaproxima/xb-demo --stability=dev

ddev drush si -y
ddev drush user:login canvas/canvas_page/1/editor
```

Now open the link Drush generated at the end to go right into Experience Builder.

You don't _have_ to use DDEV; any tech stack that supports Drupal should work just fine.

## Issues and Help

- Issues found in the demo should be submitted at https://github.com/phenaproxima/xb-demo/issues
- Problems or suggestions for Experience Builder should be submitted at https://www.drupal.org/project/issues/canvas
- Want to chat? [Find us in the #experience-builder-is-now-drupal-canvas channel on Drupal Slack.](https://drupal.slack.com/archives/C072JMEPUS1)
