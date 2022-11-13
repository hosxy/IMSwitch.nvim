local default_configs = require('IMSwitch/config')

local setup = function(configs)
    if configs == nil then
        configs = {}
    end

    setmetatable(configs,default_configs)

    if configs.input_method == "fcitx5" then
        IMSwitch = require('IMSwitch/InputMethod/fcitx5')
    elseif configs.input_method == "fcitx5_rime" then
        IMSwitch = require('IMSwitch/InputMethod/fcitx5_rime')
    elseif configs.input_method == "windows" then
        IMSwitch = require('IMSwitch/InputMethod/windows')
    else
        return {setup = setup}
    end

    local IM_Switch = vim.api.nvim_create_augroup('IM_Switch', { clear = false })
    vim.api.nvim_create_autocmd({"InsertEnter"},{
        group = IM_Switch,
        pattern = "*",
        callback = function()
            IMSwitch.InsertEnter()
        end,
    })

    vim.api.nvim_create_autocmd({"InsertLeave"},{
        group = IM_Switch,
        pattern = "*",
        callback = function()
            IMSwitch.InsertLeave()
        end,
    })

    if configs.disable_im == true then
        vim.api.nvim_create_autocmd({"UIEnter"},{
        group = IM_Switch,
        pattern = "*",
        callback = function()
            IMSwitch.deactivate_im()
        end,
    })
        
    end

end

return {setup=setup}
