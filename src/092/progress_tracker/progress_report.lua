
local progress_report_file = ""

progress_report = {}

function progress_report.initialize_file(path)
  progress_report_file = path
  local file = io.open(progress_report_file,"w")
  file:close()
end

function progress_report.write(sessionInfo, sessionSave)
  --session.previousAcquiredItem, despite its name, is updated with item acquire status of
  --the "current" frame after acquiredItemInfo() call in main loop.
  
  local parse_configs = {
    { category = "item", progress = sessionInfo.previousAcquiredItem },
    { category = "check", progress = sessionSave.checks }
  }
  local progressTable = {}
  for i, config in ipairs(parse_configs) do
    -- It's possible that target object is not created yet during boot sequence
    if config.progress then
      for k, v in pairs(config.progress) do
        -- copy the same formula to get item ID and value in acquiredItemInfo()
        for iB=0,7,1 do
          local num = k * 8 + iB
          local id = game_id_table.get_id(config.category, num)
          if id then
            local value = v % 2
            table.insert(progressTable, string.format("%s=%s",id,value))
          end
          v = v // 2
        end
      end
    end
  end

  local file = io.open(progress_report_file,"w")
  table.sort(progressTable)
  for i, progress in ipairs(progressTable) do
    file:write(string.format("%s\n", progress))
  end
  file:close()
end
