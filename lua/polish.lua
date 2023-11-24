-- Always use specific node version instead of nvm
local nodePath = "C:\\Users\\obezhenar\\AppData\\Roaming\\nvm\\v18.17.1"
local currentPath = os.getenv "PATH"
local updatedPath = nodePath .. ";" .. currentPath
vim.fn.setenv("PATH", updatedPath)
