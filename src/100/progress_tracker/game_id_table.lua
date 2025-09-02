
game_id_table = {}

local table = {
  item = {},
  check = {}
}

function game_id_table.build_table()
  -- item_id_table and check_id_table is a list of
  -- [number ID used by sessionSave and session.previousAcquiredItem in boot.lua]=[English ID in idCheck.json and idItem.json]

  local build_table_configs = {
    { key = "item", file = "item_id_table.txt" },
    { key = "check", file = "check_id_table.txt" }
  }

  for i, config in ipairs(build_table_configs) do
    for line in io.lines("./progress_tracker/data/" .. config.file) do
      for strnum, id in string.gmatch(line, "(%w+)=([%w_]+)") do
        local num = tonumber(strnum)
        table[config.key][num] = id
      end
    end
  end
end

function game_id_table.get_id(category, num)
  -- category should be "item" or "check"
  return table[category][num];
end
