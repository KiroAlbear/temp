//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dio_builder/dio_builder_plugin.h>
#include <file_selector_linux/file_selector_plugin.h>
#include <transition_easy/transition_easy_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dio_builder_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DioBuilderPlugin");
  dio_builder_plugin_register_with_registrar(dio_builder_registrar);
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) transition_easy_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TransitionEasyPlugin");
  transition_easy_plugin_register_with_registrar(transition_easy_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
