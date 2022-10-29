local configs = {}
configs.__index = configs

if jit.os == "Windows" then
    configs.input_method = "windows"
else
    configs.input_method = "fcitx5"
end

configs.disable_im = false

return configs
