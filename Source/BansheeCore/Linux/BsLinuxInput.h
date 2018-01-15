//********************************** Banshee Engine (www.banshee3d.com) **************************************************//
//**************** Copyright (c) 2016 Marko Pintera (marko.pintera@gmail.com). All rights reserved. **********************//
#pragma once

#include "BsCorePrerequisites.h"
#include "Input/BsInputFwd.h"

namespace bs
{
	/** Infomation about an analog axis that's part of a gamepad. */
	struct AxisInfo
	{
		INT32 axisIdx;
		INT32 min;
		INT32 max;
	};

	/** Information about a gamepad. */
	struct GamepadInfo
	{
		UINT32 id;
		UINT32 eventHandlerIdx;
		String name;

		UnorderedMap<INT32, ButtonCode> buttonMap;
		UnorderedMap<INT32, AxisInfo> axisMap;
	};

	/**
	 * Data specific to Linux implementation of the input system. Can be passed to platform specific implementations of
	 * the individual device types.
	 */
	struct InputPrivateData
	{
		Vector<GamepadInfo> gamepadInfos;
		Vector<INT32> mice;
		Vector<INT32> keyboards;
	};

	/**
	 * Data about relative pointer / scroll wheel movement.
	 */
	struct LinuxMouseMotionEvent
	{
		double deltaX;
		double deltaY;

		/**
		 * Relative vertical scroll amount.
		 */
		double deltaZ;
	};

	/**
	 * Data about a single button press or release.
	 */
	struct LinuxButtonEvent
	{
		UINT64 timestamp;
		ButtonCode button;
		bool pressed;
	};

#define BUFFER_SIZE_GAMEPAD 64
#define BUFFER_SIZE_KEYBOARD 128
#define BUFFER_SIZE_MOUSE 16
}

