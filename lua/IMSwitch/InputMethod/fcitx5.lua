local utils = {}
utils.im_status = false  --false:inactive, true:active

local function dbus_cmd_fcitx5(cmd)
	return "dbus-send --session --print-reply=literal --type=method_call --dest=org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1."..cmd
end

utils.ImStatus = function()
    local status = string.match(io.popen(dbus_cmd_fcitx5("State")):read("*a"),"(%d)%c")
    if status == '2' then
        return true
    else
        return false
    end
end


utils.enableIm = function()
    os.execute(dbus_cmd_fcitx5("Activate"))
end

utils.disableIm = function()
    os.execute(dbus_cmd_fcitx5("Deactivate"))
end


utils.InsertEnter = function()
    if utils.im_status == true then
        utils.enableIm(ImName)
    end
end

utils.InsertLeave = function()
    utils.im_status = utils.ImStatus()
    if utils.im_status == true then
        utils.disableIm()
    end
end

return utils
