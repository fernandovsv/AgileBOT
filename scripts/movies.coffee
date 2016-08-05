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
#   hubot cinema dd/mm - Shows the movies for that date

channels = [
  "cininvolves",
  "canaldobot",
  "Shell"
]

MoviesHelper = require('../utils/movieshelper')

module.exports = (robot) ->

	robot.respond /cinema [0-9]{1,2}\/[0-9]{1,2}/i, (res) ->
		dateText = /[0-9]{1,2}\/[0-9]{1,2}/.exec(res.message.text)[0]

		res.reply "Buscando os filmes do dia #{dateText}"

		try
			MoviesHelper.get_movies dateText, (movies) ->
				res.reply "Aqui estão os filmes!\n#{movies}"
		catch e
			res.reply e