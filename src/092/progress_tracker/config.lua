

local configFile = "./progress_tracker/config.ini"

local config_table = {}
config = {}

function config.initialize()
  for line in io.lines(configFile) do
    for key, value in string.gmatch(line, "([%w_]+)=(.+)$") do
      config_table[key] = value
    end
  end
end

function config.get(key)
  return config_table[key]
end

function config.isEnabled(key)
  return config_table[key] == "1"
end
