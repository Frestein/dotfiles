local cmd

if vim.fn.executable "qmlls" == 0 and vim.fn.executable "qmlls6" == 1 then
	cmd = { "qmlls6" }
else
	cmd = { "qmlls" }
end

return { cmd = cmd }
