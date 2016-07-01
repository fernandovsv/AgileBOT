# Description
#	Fix iOS typo

module.exports = (robot) ->

	robot.hear /\bios\b/i, (res) ->
		channelName = res.message.room
		text = res.message.text
		index = text.search /\bios\b/i
		text = text.substr(index, 3)

		if text isnt "iOS" and (channelName is "mobile" or channelName is "agile-ios" or channelName is "general" or channelName is "Shell")
			count = robot.brain.get('dolphin_killed_count') + 1
			robot.brain.set('dolphin_killed_count', count)
			res.send "Você acabou de matar #{":dagger_knife:"} um #{":dolphin:"} ao escrever \"iOS\" errado. Golfinhos mortos: #{count}"