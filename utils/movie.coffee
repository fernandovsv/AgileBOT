class Movie
	constructor: (@name, @genre, @is3D, @sessions) ->

	display: () ->
		text = "#{@name}"

		if @is3D
			text = text + " (3D)"

		text = text + " - " + (@sessions.map (session) ->
			session.display()
			).join(" | ")

module.exports = Movie