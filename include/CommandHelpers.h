/* ***************************************************************************
 * Copyright (c) 2023 Philip Fadriquela
 * pjfadriquela@gmail.com
 * All rights reserved.
 * **************************************************************************/
#pragma once
#include <stdint.h>
#include "ErrorCodes.h"


// TX client class to sending a packed struct and parsing the response
class ClientCommandResponseStream
{
public:
    ClientCommandResponseStream()
    {}

    ErrorCode sendReceive(uint16_t var);
};


// RX Server class to reading a packed struct and parsing the response
class ServerCommandResponseStream
{
public:
    ServerCommandResponseStream()
    {};

    // to be implemented by os task
    void dispatchCommand(uint16_t var);
};
