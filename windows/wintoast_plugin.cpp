#include "include/wintoast/wintoast_plugin.h"
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>


namespace {

	class WintoastPlugin : public flutter::Plugin {
		public:
		static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

		WintoastPlugin();

		virtual ~WintoastPlugin();

		private:
		void HandleMethodCall(
			const flutter::MethodCall<flutter::EncodableValue> &method_call,
			std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
	};

	void WintoastPlugin::RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar) {
	auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(registrar->messenger(), "wintoast", &flutter::StandardMethodCodec::GetInstance());

	auto plugin = std::make_unique<WintoastPlugin>();

	channel->SetMethodCallHandler(
		[plugin_pointer = plugin.get()](const auto &call, auto result) {
			plugin_pointer->HandleMethodCall(call, std::move(result));
		});

	registrar->AddPlugin(std::move(plugin));
	}

	WintoastPlugin::WintoastPlugin() {}

	WintoastPlugin::~WintoastPlugin() {}

	void WintoastPlugin::HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &method_call, std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
		result->NotImplemented();
	}

}

void WintoastPluginRegisterWithRegistrar(FlutterDesktopPluginRegistrarRef registrar) {
  	WintoastPlugin::RegisterWithRegistrar(
	  	flutter::PluginRegistrarManager::GetInstance()->GetRegistrar<flutter::PluginRegistrarWindows>(registrar)
	);
}
