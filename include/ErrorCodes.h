/* ***************************************************************************
 * Copyright (c) 2023 Philip Fadriquela
 * pjfadriquela@gmail.com
 * All rights reserved.
 * **************************************************************************/

#pragma once
#include <stdint.h>


typedef uint16_t ErrorCode;


/// Command layer error codes. Most of these can be placed in an outgoing error
/// response.  However, \p CmdErr_SuspendResponse and \p CmdErr_DontExtendSession
/// result in no response message being sent.
///
/// \note Do not add error codes in the middle, so as not break backward
/// compatibility of existing tools.
namespace ErrorCodes
{
    constexpr ErrorCode None = 0x00U;
    constexpr ErrorCode GenericError = 0x01U;
};