# Description:
#   Shows the movies for a given date
#
#
# Dependencies:
#   "htmlparser": "1.7.7"
#   "soupselect": "0.2.0"
#
#
# Commands:
#   hubot cinema <hoje|amanhã|dd/mm> - Shows the movies for that date
#	hubot cinema salas - Shows the available rooms for Involves

channels = [
  "cininvolves",
  "general",
  "canaldobot",
  "Shell"
]

MoviesHelper = require('../utils/movieshelper')
Session = require('../utils/session')

module.exports = (robot) ->

	robot.respond /cinema ([0-9]{1,2}\/[0-9]{1,2}|hoje|amanhã|amanha)/i, (res) ->
		if res.message.room in channels
			dateText = /([0-9]{1,2}\/[0-9]{1,2}|hoje|amanhã|amanha)/i.exec(res.message.text)[0]

			res.reply "Buscando os filmes de #{dateText}"

			try
				MoviesHelper.get_movies dateText, (movies) ->
					res.reply "Aqui estão os filmes!\n#{movies}"
			catch e
				res.reply e

	robot.respond /cinema salas/i, (res) ->
		if res.message.room in channels
			res.reply "As salas que vocês podem ir são: #{Session.avaliableRooms.join(", ")}"