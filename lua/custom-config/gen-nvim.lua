--[[ /// <summary>
    /// [summary_here]
    /// </summary> ]]
local gen = require "gen"

gen.prompts['Summarize_Function'] = {
  prompt = "Write a short summary (maximum one paragraph and two sentences) for the following method, start:\n$text",
  replace = false
}

return {}
