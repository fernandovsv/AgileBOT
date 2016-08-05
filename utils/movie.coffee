class Movie
	constructor: (@name, @genre, @sessions) ->

	display: () ->
		"#{@name} - " + (@sessions.map (session) ->
			session.display()
			).join(" | ")

module.exports = Movie