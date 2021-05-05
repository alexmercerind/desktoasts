#include "include/desktoasts/desktoasts_plugin.h"
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>


namespace {

	class DesktoastsPlugin : public flutter::Plugin {
		public:
		static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

		DesktoastsPlugin();

		virtual ~DesktoastsPlugin();

		private:
		void HandleMethodCall(
			const flutter::MethodCall<flutter::EncodableValue> &method_call,
			std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
	};

	void DesktoastsPlugin::RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar) {
	auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(registrar->messenger(), "Desktoasts", &flutter::StandardMethodCodec::GetInstance());

	auto plugin = std::make_unique<DesktoastsPlugin>();

	channel->SetMethodCallHandler(
		[plugin_pointer = plugin.get()](const auto &call, auto result) {
			plugin_pointer->HandleMethodCall(call, std::move(result));
		});

	registrar->AddPlugin(std::move(plugin));
	}

	DesktoastsPlugin::DesktoastsPlugin() {}

	DesktoastsPlugin::~DesktoastsPlugin() {}

	void DesktoastsPlugin::HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &method_call, std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
		result->NotImplemented();
	}

}

void DesktoastsPluginRegisterWithRegistrar(FlutterDesktopPluginRegistrarRef registrar) {
  	DesktoastsPlugin::RegisterWithRegistrar(
	  	flutter::PluginRegistrarManager::GetInstance()->GetRegistrar<flutter::PluginRegistrarWindows>(registrar)
	);
}
