/*
 * MIT License
 * 
 * Copyright (c) 2021 Hitesh Kumar Saini
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/

#include <functional>

#include "WinToast/src/wintoastlib.cpp"
#include "callback_manager.hpp"

#define UNICODE
#ifndef DESKTOASTS_HEADER
#define DESKTOASTS_HEADER


using namespace WinToastLib;


class ToastServiceHandler: public IWinToastHandler {
    void toastActivated() const override {
        const char* event[2] = {"activateEvent", "0"};
        callbackStringArray(2, const_cast<char**>(event));
    }

    void toastActivated(int index) const override {
        char* _index;
        itoa(index, _index, 10);
        const char* event[2] = {"interactEvent", _index};
        callbackStringArray(2, const_cast<char**>(event));
    }

    void toastDismissed(WinToastDismissalReason state) const override {
        char* _state;
        itoa(state, _state, 10);
        const char* event[2] = {"dismissEvent", _state};
        callbackStringArray(2, const_cast<char**>(event));
    }

    void toastFailed() const override {
        const char* event[2] = {"failEvent", "0"};
        callbackStringArray(2, const_cast<char**>(event));
    }
};


class Toast {
public:
    std::wstring image;
    std::wstring title;
    std::wstring subtitle;

    friend class ToastService;
    
    Toast(int type, std::wstring title, std::wstring subtitle = L"", std::wstring image = L"", std::vector<std::wstring> actions = {}) {
        this->image = image;
        this->title = title;
        this->subtitle = subtitle;
        this->toastTemplate = new WinToastTemplate(
            static_cast<WinToastTemplate::WinToastTemplateType>(type)
        );
        if (title != L"")
            this->toastTemplate->setFirstLine(title);
        if (subtitle != L"")
            this->toastTemplate->setSecondLine(subtitle);
        if (image != L"")
            this->toastTemplate->setImagePath(image);
        if (actions.size() != 0)
            for (std::wstring &action: actions)
                this->toastTemplate->addAction(action);
    }

    ~Toast() {
        delete this->toastTemplate;
    }

private:
    WinToastTemplate* toastTemplate;

    void show(ToastServiceHandler* handler) {
        WinToast::instance()->showToast(*this->toastTemplate, handler);
    }
};


class ToastService {
public:

    ToastService(std::wstring appName, std::wstring companyName, std::wstring productName, std::wstring subProductName = L"", std::wstring versionInformation = L"") {
        handler = new ToastServiceHandler();
        WinToast::instance()->setAppName(appName);
        std::wstring aumi = WinToast::configureAUMI(
            companyName,
            productName,
            subProductName,
            versionInformation
        );
        WinToast::instance()->setAppUserModelId(aumi);
        WinToast::instance()->initialize();
    }

    void dispose() {
        delete this->handler;
    }

    void show(Toast* toast) {
       WinToast::instance()->showToast(
            *toast->toastTemplate,
            this->handler
        );
    }

    static bool isCompatible() {
        return WinToast::isCompatible();
    }

private:
    ToastServiceHandler* handler;
};

#endif
