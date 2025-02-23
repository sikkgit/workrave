// Copyright (C) 2001 - 2021 Rob Caelers & Raymond Penners
// All rights reserved.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif

#include "ui/windows/WindowsHarpoonLocker.hh"

#include "input-monitor/Harpoon.hh"

bool
WindowsHarpoonLocker::can_lock()
{
  return true;
}

void
WindowsHarpoonLocker::block_input(bool block)
{
  if (block)
    {
      Harpoon::block_input();
    }
  else
    {
      Harpoon::unblock_input();
    }

  UINT uPreviousState;
  SystemParametersInfo(SPI_SETSCREENSAVERRUNNING, block, &uPreviousState, 0);
}

void
WindowsHarpoonLocker::lock()
{
  block_input(TRUE);
}

void
WindowsHarpoonLocker::unlock()
{
  block_input(FALSE);
}
