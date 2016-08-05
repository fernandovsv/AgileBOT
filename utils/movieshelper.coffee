select = require('soupselect').select
htmlparser = require("htmlparser")
http = require('http')
Movie = require('./movie')
Session = require('./session')

class MoviesHelper
	@get_movies = (date_text, callback) ->
		dateParam = MoviesHelper.get_url_date_param(date_text)

		url = "http://www.cinesystem.com.br/#{dateParam}"

		req = http.get url, (res) ->
			status = res.statusCode
			if status != 200
				throw "Não consegui pegar os filmes! So sorry!"
			else
				body = ""

				res.on 'end', ->
					MoviesHelper.parse_body body, (movies) ->
						callback movies

				res.on 'data', (chunk) ->
					body = body + chunk

		req.on 'error', ->
			throw "Sem internet?!"

	@get_url_date_param = (dateText) ->
		now = new Date()
		now.setHours(0,0,0,0)

		dateArray = dateText.split("/")
		selectedDate = new Date(now.getFullYear(), parseInt(dateArray[1] - 1), parseInt(dateArray[0]))
		
		days = MoviesHelper.days_diff(now, selectedDate)

		if days >= 7
			throw "A programação muda toda quinta-feira, não consigo pegar os filmes."
		else if days > 0
			url = "/florianopolis/programacao/data-" + days
		else
			url = "/florianopolis/programacao"

		return url

	@days_diff = (first, second) ->
		return (second - first) / (1000 * 60 * 60 * 24)

	@show_movies = (movies) ->
		return (movies.map (movie) ->
			movie.display()
			).join("\n")

	@parse_body = (body, callback) ->
		handler = new htmlparser.DefaultHandler (err, dom) ->
			if (err)
				console.log("Error: " + err)
			else
				ulTag = select(dom, 'ul.repeat-filmes')[0]
				movies = MoviesHelper.parse_movies ulTag
				callback MoviesHelper.show_movies movies

		parser = new htmlparser.Parser(handler)
		parser.parseComplete(body)

	@parse_movies = (moviesTag) ->
		movies = []

		for liTag in select(moviesTag, 'li')
			name = MoviesHelper.parse_movie_name(select(liTag, 'td.name')[0])

			genre = MoviesHelper.parse_movie_genre(select(liTag, 'td.categoria')[1])

			sessoesTags = select(liTag, 'td.sessoes')
			bodyTags = select(sessoesTags, 'tbody')

			sessions = []

			select(bodyTags, 'tr').forEach (sessionTag) ->
				sessions.push MoviesHelper.parse_movie_session(sessionTag)

			movies.push new Movie(name, genre, sessions)

		return movies

	@parse_movie_genre = (tdTag) ->
		return tdTag.children[0].data

	@parse_movie_name = (tdTag) ->
		h2Tag = select(tdTag, 'h2')[0]
		return h2Tag.children[0].data

	@parse_movie_session = (sessionTag) ->
		room = sessionTag.children[3].children[0].children[0].data.trim()
		times = sessionTag.children[3].children[1].data.split(",")
		type = sessionTag.children[1].children[0].data.trim()

		return new Session(room, type, times)

module.exports = MoviesHelper