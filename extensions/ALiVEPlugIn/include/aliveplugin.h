/*!
 * \brief   Arma Entry Point
 * \details These functions will handle the RVExtension entry point for Arma.
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#ifndef ALIVEPLUGIN_H_
#define ALIVEPLUGIN_H_

#include "alive.h"

void ALiVE_Extension(char *output, int outputSize, const char *function);

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __gnu_linux__
    void RVExtension(char *output, int outputSize, const char *function);
#else
    void __stdcall __declspec(dllexport) _RVExtension(char *output, int outputSize, const char *function);
#endif

#ifdef __cplusplus
}
#endif

#endif // ALIVEPLUGIN_H_
