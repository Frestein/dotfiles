local function plain_text_symbol(symbol)
	local res = {}

	-- Indicator that shows if there are any other symbols in the same line
	local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

	if symbol.references then
		local usage = symbol.references <= 1 and "usage" or "usages"
		local num = symbol.references == 0 and "no" or symbol.references
		table.insert(res, { "󰌹 ", "SymbolUsageRef" })
		table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
	end

	if symbol.definition then
		if #res > 0 then
			table.insert(res, { " ", "NonText" })
		end
		table.insert(res, { "󰳽 ", "SymbolUsageDef" })
		table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
	end

	if symbol.implementation then
		if #res > 0 then
			table.insert(res, { " ", "NonText" })
		end
		table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
		table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
	end

	if stacked_functions_content ~= "" then
		if #res > 0 then
			table.insert(res, { " ", "NonText" })
		end
		table.insert(res, { " ", "SymbolUsageImpl" })
		table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
	end

	return res
end

return {
	"Wansmer/symbol-usage.nvim",
	recommended = true,
	desc = "Display references, definitions and implementations of document symbols without textDocument/codelens support",
	event = "LspAttach",
	opts = {
		---@type 'above'|'end_of_line'|'textwidth'|'signcolumn' `above` by default
		vt_position = "end_of_line",
		---The function can return a string to which the highlighting group from `opts.hl` is applied.
		---Alternatively, it can return a table of tuples of the form `{ { text, hl_group }, ... }`` - in this case the specified groups will be applied.
		---If `vt_position` is 'signcolumn', then only a 1-2 length string or a `{{ icon, hl_group }}` table is expected.
		---See `#format-text-examples`
		---@type function(symbol: Symbol): string|table Symbol{ definition = integer|nil, implementation = integer|nil, references = integer|nil, stacked_count = integer, stacked_symbols = table<SymbolId, Symbol> }
		text_format = plain_text_symbol,
		---Text to display when request is pending. If `false`, extmark will not be
		---created until the request is finished. Recommended to use with `above`
		---vt_position to avoid "jumping lines".
		---@type string|table|false
		request_pending_text = false,
		definition = { enabled = false },
		implementation = { enabled = false },
	},
}
