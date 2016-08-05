class Session
	constructor: (@room, @type, @times) ->

	display: () ->
		"#{@room} - #{@type} - " + @times.join(", ")

module.exports = Session