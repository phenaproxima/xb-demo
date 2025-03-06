<?php

declare(strict_types=1);

use Drupal\Core\DefaultContent\Finder;
use Drupal\Core\DefaultContent\Importer;
use Drupal\Core\Entity\EntityRepositoryInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Site\Settings;
use Drupal\dashboard\Entity\Dashboard;
use Drupal\RecipeKit\Installer\Hooks;
use Drupal\RecipeKit\Installer\Messenger;

/**
 * Implements hook_install_tasks().
 */
function drupal_cms_installer_install_tasks(): array {
  $tasks = [
    'xb_demo_alter_welcome_links' => [],
  ] + Hooks::installTasks();

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

  // The recipe kit doesn't change the title of the batch job that applies all
  // the recipes, so to override it, we use core's custom string overrides.
  // We can't use the passed-in $install_state here, because it isn't passed by
  // reference.
  $langcode = $GLOBALS['install_state']['parameters']['langcode'];
  $settings = Settings::getAll();
  // @see install_profile_modules()
  $settings["locale_custom_strings_$langcode"]['']['Installing @drupal'] = 'Setting up your site';
  new Settings($settings);
}

/**
 * Implements hook_form_alter().
 */
function drupal_cms_installer_form_alter(array &$form, FormStateInterface $form_state, string $form_id): void {
  Hooks::formAlter($form, $form_state, $form_id);
}

/**
 * Implements hook_form_alter() for install_configure_form.
 */
function drupal_cms_installer_form_install_configure_form_alter(array &$form): void {
  // We always install Automatic Updates, so we don't need to expose the update
  // notification settings.
  $form['update_notifications']['#access'] = FALSE;

  // Hard-code the initial site name.
  $form['site_information']['site_name'] = [
    '#type' => 'hidden',
    '#default_value' => 'Experience Builder Demo',
  ];
}

function xb_demo_alter_welcome_links(): void {
  // Remove the "Create content" link, since this demo is not content-first.
  \Drupal::service(EntityRepositoryInterface::class)
    ->loadEntityByUuid('menu_link_content', '848d74e6-922c-42c4-9049-7004fac527c3')
    ?->delete();

  // Import menu links shipped with this demo.
  \Drupal::service(Importer::class)->importContent(
    new Finder(__DIR__ . '/content/menu_link_content'),
  );

  // Replace the dashboard's recent content block with a listing of pages.
  $dashboard = Dashboard::load('welcome');
  $component = $dashboard->getSection(0)->getComponent('95005442-e22e-4068-bcac-814fb6c1ccc4');
  ['configuration' => $configuration] = $component->toArray();
  $configuration['id'] = 'views_block:pages-block_1';
  $component->setConfiguration($configuration);
  $dashboard->save();
}
