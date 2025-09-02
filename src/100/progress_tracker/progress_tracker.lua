package.path = package.path .. ";./progress_tracker/?.lua"

require("config")
config.initialize()

require('game_id_table')
game_id_table.build_table()

require "item_log"
require "item_id_log"
require "progress_report"

progress_tracker = {}

function progress_tracker.initialize()
  if config.isEnabled("item_log_enabled") then
    item_log.initialize_textlog(config.get("item_log_path"))
  end
  if config.isEnabled("item_id_log_enabled") then
    item_id_log.initialize_file(config.get("item_id_log_path"))
  end
  if config.isEnabled("progress_report_enabled") then
    progress_report.initialize_file(config.get("progress_report_path"))
  end
end

function progress_tracker.onAcquireItem(sessionInfo, sessionSave)
  if config.isEnabled("item_log_enabled") then
    item_log.get_item_textlog(sessionInfo.acquiredItem)
  end
  if config.isEnabled("item_id_log_enabled") then
    item_id_log.append_log(sessionInfo.acquiredItem)
  end
  if config.isEnabled("progress_report_enabled") then
    progress_report.write(sessionInfo, sessionSave)
  end
end

function progress_tracker.onSyncProgress(sessionInfo, sessionSave)
  if config.isEnabled("progress_report_enabled") then
    progress_report.write(sessionInfo, sessionSave)
  end
end

progress_tracker.initialize()
