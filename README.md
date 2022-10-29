# IMSwitch.nvim

## Installation
+ packer:
```
use 'hosxy/IMSwitch.nvim'
```

## Configuration
+ `input_method`
  + description: input method name 
  + type: string
  + value: `fcitx5` or `fcitx5_rime` or `windows`
  + default: `fcitx5`(default: `windows` on Windows)
+ `disable_im`
  + description: disable input method after nvim start(if your default input method isn't Eng,maybe need this,maybe don't work)
  + type: boolean
  + value: `true` or `false`
  + default: `false`




## Example
```
require("IMSwitch").setup{
    input_method = "fcitx5",
    disable_im = false,
}
```
