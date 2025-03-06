local core = require("nvim-tree.core")
local actions = require("mcalvaro.utils.nvim-tree.actions.create_java_class")

function wrap_node_or_nil(fn, class_type)
	return function(node, ...)
		local explorer = core.get_explorer()
		if not explorer then
			return
		end
		node = node or explorer:get_node_at_cursor()
		fn(node, class_type, ...)
	end
end

function create_java()
	local wraped_action = wrap_node_or_nil(actions.fn)
	wraped_action()
end

local class_types = { "Class", "Interface", "Enum", "Record" }

function create_java_class()
	vim.ui.select(class_types, {

		prompt = "New Java Class",
		telescope = require("telescope.themes").get_dropdown(),
	}, function(selected)
		if not selected then
			return
		end

		local wraped_action = wrap_node_or_nil(actions.fn, selected)
		wraped_action()
	end)
end
