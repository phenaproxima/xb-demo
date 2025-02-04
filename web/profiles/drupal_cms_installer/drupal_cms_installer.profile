<?php

declare(strict_types=1);

use Drupal\Core\Form\FormStateInterface;
use Drupal\RecipeKit\Installer\Hooks;
use Drupal\RecipeKit\Installer\Messenger;

/**
 * Implements hook_install_tasks().
 */
function drupal_cms_installer_install_tasks(): array {
  $tasks = Hooks::installTasks();

  if (getenv('IS_DDEV_PROJECT')) {
    Messenger::reject(
      'All necessary changes to %dir and %file have been made, so you should remove write permissions to them now in order to avoid security risks. If you are unsure how to do so, consult the <a href=":handbook_url">online handbook</a>.',
    );
  }
  return $tasks;
}

/**
 * Implements hook_install_tasks_alter().
 */
function drupal_cms_installer_install_tasks_alter(array &$tasks, array $install_state): void {
  Hooks::installTasksAlter($tasks, $install_state);
}

/**
 * Implements hook_form_alter().
 */
function drupal_cms_installer_form_alter(array &$form, FormStateInterface $form_state, string $form_id): void {
  Hooks::formAlter($form, $form_state, $form_id);
}

/**
 * Implements hook_form_alter() for installer_site_name_form.
 */
function drupal_cms_installer_form_installer_site_name_form_alter(array &$form): void {
  $form['#title'] = t('Give your site a name');

  $form['help'] = [
    '#prefix' => '<p class="cms-installer__subhead">',
    '#markup' => t('You can change this later.'),
    '#suffix' => '</p>',
    '#weight' => -100,
  ];
  $form['site_name'] += [
    '#prefix' => '<div class="cms-installer__form-group">',
    '#suffix' => '</div>',
  ];
  $form['actions']['submit']['#attributes']['class'] = ['button--next'];
}

/**
 * Implements hook_form_alter() for installer_recipes_form.
 */
function drupal_cms_installer_form_installer_recipes_form_alter(array &$form): void {
  $form['#title'] = t('Get started');

  $form['help'] = [
    '#prefix' => '<p class="cms-installer__subhead">',
    '#markup' => t('You can select pre-configured types of content now, or add them later.'),
    '#suffix' => '</p>',
    '#weight' => -100,
  ];
  $form['add_ons'] += [
    '#prefix' => '<div class="cms-installer__form-group">',
    '#suffix' => '</div>',
  ];
  $form['add_ons']['help'] = [
    '#prefix' => '<p class="cms-installer__info">',
    '#markup' => t('Don’t see what you’re looking for? You can set up customized content later.'),
    '#suffix' => '</p>',
    '#weight' => 100,
  ];

  $form['actions']['submit']['#attributes']['class'] = ['button--next'];
}

/**
 * Implements hook_form_alter() for install_settings_form.
 */
function drupal_cms_installer_form_install_settings_form_alter(array &$form): void {
  $form['help'] = [
    '#prefix' => '<p class="cms-installer__subhead">',
    '#markup' => t("You don't need to change anything here unless you want to use a different database type."),
    '#suffix' => '</p>',
    '#weight' => -50,
  ];
}

/**
 * Implements hook_form_alter() for install_configure_form.
 */
function drupal_cms_installer_form_install_configure_form_alter(array &$form): void {
  $form['#title'] = t('Create your account');

  $form['help'] = [
    '#prefix' => '<p class="cms-installer__subhead">',
    '#markup' => t('Creating an account allows you to log in to your site.'),
    '#suffix' => '</p>',
    '#weight' => -40,
  ];

  // We always install Automatic Updates, so we don't need to expose the update
  // notification settings.
  $form['update_notifications']['#access'] = FALSE;

  $form['admin_account']['account']['mail'] += [
    '#prefix' => '<div class="cms-installer__form-group">',
    '#suffix' => '</div>',
  ];
  $form['admin_account']['account']['pass'] += [
    '#prefix' => '<div class="cms-installer__form-group">',
    '#suffix' => '</div>',
  ];
}

/**
 * Implements hook_library_info_alter().
 */
function drupal_cms_installer_library_info_alter(array &$libraries, string $extension): void {
  Hooks::libraryInfoAlter($libraries, $extension);
}

/**
 * Implements hook_theme_registry_alter().
 */
function drupal_cms_installer_theme_registry_alter(array &$hooks): void {
  Hooks::themeRegistryAlter($hooks);
}

/**
 * Preprocess function for all theme hooks.
 */
function drupal_cms_installer_preprocess(array &$variables): void {
  Hooks::preprocess($variables);
}
