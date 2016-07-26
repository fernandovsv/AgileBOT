# Description:
#   Shows the movies for a given date
# Commands:
#   hubot cinema dd/mm - Shows the movies for that date

module.exports = (robot) ->

	robot.respond /cinema [0-9]{2}\/[0-9]{1,2}/i, (res) ->
		dateText = /[0-9]{2}\/[0-9]{1,2}/.exec(res.message.text)[0]

		url = getURL(dateText)

		debugger

		res.reply "Hi! URL is #{url}"

	getURL = (dateText) ->
		debugger

		now = new Date()
		now.setHours(0,0,0,0)

		dateArray = dateText.split("/")
		selectedDate = new Date(now.getFullYear(), parseInt(dateArray[1] - 1), parseInt(dateArray[0]))
		
		days = daydiff(now, selectedDate)

		if days > 0
			url = "/florianopolis/programacao/data-" + days
		else
			url = "/florianopolis/programacao"

		return url

	daydiff = (first, second) ->
		return (second - first) / (1000 * 60 * 60 * 24)