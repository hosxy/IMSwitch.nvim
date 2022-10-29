local utils = {}

utils.imstatus = false  --false:inactive, true:active

local ffi = require 'ffi'
local imm32 = ffi.load('imm32.dll')
local user32 = ffi.load('user32.dll')

ffi.cdef[[
    typedef int BOOL;
    typedef unsigned int UINT,UNIT_PTR,WPARAM;
    typedef long LOOG_PTR,LPARAM,LRESULT; 
    typedef unsigned long DWORD,HIMC,*LPDWORD;
    typedef void *HANDLE;
    typedef HANDLE HWND,HKL;

    
    HWND GetForegroundWindow();
	HWND ImmGetDefaultIMEWnd(HWND);
	LRESULT SendMessageW(HWND,UINT,WPARAM,LPARAM);
]]

get_hwnd = function()
	return imm32.ImmGetDefaultIMEWnd(user32.GetForegroundWindow())
end

-- WM_IME_CONTROL：0x283
-- IMC_GETCONVERSIONMODE：0x001
-- IMC_SETOPENSTATUS：0x006

utils.im_status = function()
    if user32.SendMessageW(get_hwnd(), 0x283, 0x001, 0x000) == 0 then
        return false
    else
        return true
    end
end

utils.activate_im = function()
	user32.SendMessageW(get_hwnd(), 0x283, 0x006, 0x001)
end

utils.deactivate_im = function()
	user32.SendMessageW(get_hwnd(), 0x283, 0x006, 0x000)
end

utils.InsertEnter = function()
    if utils.imstatus == true then
        utils.activate_im()
    end
end

utils.InsertLeave = function()
    utils.imstatus = utils.im_status()
    if utils.imstatus == true then
        utils.deactivate_im()
    end
end

return utils