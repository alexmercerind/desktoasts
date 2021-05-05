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

#include "desktoasts.hpp"


#ifdef __cplusplus
extern "C" {
#endif

ToastService* service = nullptr;
std::vector<Toast*> toasts;

EXPORT void ToastService_create(const char** data) {
    if (service == nullptr)
        service = new ToastService(data[0], data[1], data[2], data[3], data[4]);
}

EXPORT void ToastService_show(int id) {
    if (service != nullptr && toasts[id] != nullptr)
        service->show(toasts[id]);
}

EXPORT void ToastService_dispose() {
    if (service != nullptr) {
        service->dispose();
        service = nullptr;
    }
}

EXPORT int Toast_create(const char** data, int length) {
    std::vector<std::string> actions;
    for (int index = 4; index < length; index++) {
        actions.emplace_back(data[index]);
    }
    Toast* toast = new Toast(
        atoi(data[0]),
        data[1],
        data[2],
        data[3],
        actions
    );
    toasts.emplace_back(toast);
    return toasts.size() - 1;
}

EXPORT void Toast_dispose(int id) {
    delete toasts[id];
    toasts[id] = nullptr;
}

#ifdef __cplusplus
}
#endif
