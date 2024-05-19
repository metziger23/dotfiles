print("hello")

local path = require 'plenary.path'

local function is_qmake_config_in_cwd()
    return path:new(vim.fn.getcwd() .. "/.qmake-config.lua"):exists()
end

print(is_qmake_config_in_cwd())

local notification_displayed = false

local function is_gradle_in_cwd()
    local is_gradle = path:new(vim.fn.getcwd() .. '/gradlew'):exists()
    if is_gradle and not notification_displayed then
        require 'notify' 'Found Gradle. Creating task'
        notification_displayed = true
    end
    return is_gradle
end

return {
    name = "test",
    builder = function()
        print("hello in func")
        return {
            cmd = "echo hello",
            components = { { "on_output_quickfix", open = false }, "default" },
        }
    end,
}
