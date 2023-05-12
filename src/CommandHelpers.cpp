/* ***************************************************************************
 * Copyright (c) 2023 Philip Fadriquela
 * pjfadriquela@gmail.com
 * All rights reserved.
 * **************************************************************************/

#include <cstring>
#include "CommandHelpers.h"
#include "ErrorCodes.h"

ErrorCode ClientCommandResponseStream::sendReceive(uint16_t var)
{
   ErrorCode u16_Result = ErrorCodes::None;
   return u16_Result;
}

ErrorCode receiveSend( uint16_t var )
{
   ErrorCode u16_Result = ErrorCodes::None;
   return u16_Result;
}

void ServerCommandResponseStream::dispatchCommand(uint16_t var)
{
}
