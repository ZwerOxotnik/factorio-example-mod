--[[ Uses https://github.com/ZwerOxotnik/factorio-BetterCommands
Returns tables of commands without functions as command "settings". All parameters are optional!
	Contains:
		name :: string: The name of your /command. (default: key of the table)
		description :: string or LocalisedString: The description of your command. (default: nil)
		is_allowed_empty_args :: boolean: Ignores empty parameters in commands, otherwise stops the command. (default: true)
		input_type :: string: Filter for parameters by type of input. (default: nil)
			possible variants:
				"player" - Stops execution if can't find a player by parameter
				"team" - Stops execution if can't find a team (force) by parameter
		allow_for_server :: boolean: Allow execution of a command from a server (default: false)
		only_for_admin :: boolean: The command can be executed only by admins (default: false)
		allow_for_players :: string[]: Allows to use the command for players with specified names (default: nil)
		max_input_length :: uint: Max amount of characters for command (default: 500)
		is_logged :: boolean: Logs the command into .log file (default: false)
		alternative_names :: string[]: Alternative names for the command (all commands should be added) (default: nil)
		is_one_time_use :: boolean: Disables the command after using it (default: false)
		is_one_time_use_for_player :: boolean: Disables for a player after using it (default: false)
		is_one_time_use_for_force  :: boolean: Disables for a force after using it (default: false)
		global_cooldown :: uint: The command can be used each N seconds  (default: nil)
		player_cooldown :: uint: The command can be used each N seconds for players (default: nil)
		force_cooldown  :: uint: The command can be used each N seconds for forces (default: nil)
		disable_cooldown_for_admins :: boolean: Disables cooldown for admins (default: false)
		disable_cooldown_for_server :: boolean: Disables cooldown for server (default: true)
]]--
---@type table<string, BetterCommand>
return {
}
