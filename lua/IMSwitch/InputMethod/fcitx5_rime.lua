local utils = {}
utils.im_status = false  --false:inactive, true:active

local function dbus_cmd_fcitx5_rime(cmd)
    return "dbus-send --session --print-reply=literal --type=method_call --dest=org.fcitx.Fcitx5 /rime org.fcitx.Fcitx.Rime1."..cmd
end

utils.ImStatus = function(ImName)
    local status =  string.match(io.popen(dbus_cmd_fcitx5_rime("IsAsciiMode")):read("*a"),"%s(%l+)%c")
    if status == "false" then
        return true
    else
        return false
    end

utils.enableIm = function()
    os.execute(dbus_cmd_fcitx5_rime("SetAsciiMode boolean:false"))
end

utils.disableIm = function()
    os.execute(dbus_cmd_fcitx5_rime("SetAsciiMode boolean:true"))
end

utils.InsertEnter = function()
    if utils.im_status == true then
        utils.enableIm()
    end
end

utils.InsertLeave = function()
    utils.im_status = utils.ImStatus()
    if utils.im_status == true then
        utils.disableIm()
    end
end

return utils
