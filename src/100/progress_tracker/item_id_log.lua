-- Item ID log for other log GUI programs to parse
local item_id_log_file = ""

item_id_log = {}

function item_id_log.initialize_file(path)
  item_id_log_file = path
  local file = io.open(item_id_log_file,"w")
	file:close()
end

function item_id_log.append_log(item_num)
	-- Write new acquired Item ID to log
	local file = io.open(item_id_log_file,"a")
  file:write(string.format("%s\n", game_id_table.get_id("item", item_num)))
  file:close()
end
