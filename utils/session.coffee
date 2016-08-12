class Session
	@avaliableRooms = ["Sala 1", "Sala 2", "Sala 6", "Sala 7"]
	@specialRooms = ["Sala 3", "Sala 4", "Sala 5"]

	constructor: (@room, @type, @times) ->

	display: () ->
		text = "#{@room}"

		tech = @technology()
		if tech?
			text = text + " (#{tech})"

		text = text + " - #{@type} - " + @times.join(", ")

		if @room in Session.avaliableRooms
			text = "*#{text}*"
		return text

	technology: () ->
		if @room is "Sala 3" or @room is "Sala 5"
			return "Premium"
		else if @room is "Sala 4"
			return "Cinépic"
		else
			return null
			

module.exports = Session