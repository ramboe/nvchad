local dap = require("dap")

dap.adapters.coreclr = {
  type = "executable",
  -- command = "/usr/bin/netcoredbg",
  -- command = "/usr/local/bin/netcoredbg",
  command = "/home/ramboe/Documents/debuggers/netcoredbg/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = {
  type = "executable",
  -- command = "/usr/bin/netcoredbg",
  -- command = "/usr/local/bin/netcoredbg",
  command = "/home/ramboe/Documents/debuggers/netcoredbg/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      -- return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/src/", "file")
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
    end,
  },
}
