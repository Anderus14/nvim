require('craftzdog.base')
require('craftzdog.highlights')
require('craftzdog.maps')
require('craftzdog.plugins')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac then
  require('craftzdog.macos')
end
if is_win then
  require('craftzdog.windows')
end
if is_wsl then
  require('craftzdog.wsl')
end
vim.opt.shell = 'powershell.exe'

local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = 'C:/users/zizig/netcoredbg/build/bin/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
