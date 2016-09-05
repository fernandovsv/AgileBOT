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
		today = new Date()

		selectedDate = today
			
		if /(amanhã|amanha)/i.exec(dateText) != null
			selectedDate = new Date(selectedDate.getTime() + 86400000)
		else if /(hoje)/i.exec(dateText) == null
			dateArray = dateText.split("/")
			selectedDate = new Date(today.getFullYear(), parseInt(dateArray[1] - 1), parseInt(dateArray[0]))

		if (selectedDate.getTime() < today.getTime())
			throw "A data selecionada é menor que hoje!"
		else
			days = MoviesHelper.days_diff(today.getDate(), selectedDate.getDate())

			url = "/florianopolis/programacao"

			if days > 0
				url = url + "/data-" + days

			return url

	@days_diff = (first, second) ->
		return parseInt((second - first) / (1000 * 60 * 60 * 24))

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

				if MoviesHelper.has_movies select(ulTag, 'li')
					movies = MoviesHelper.parse_movies ulTag
					callback MoviesHelper.show_movies movies
				else
					callback "Nenhuma programação cadastrada para esta data"

		parser = new htmlparser.Parser(handler)
		parser.parseComplete(body)

	@has_movies = (liTags) ->
		liTag = liTags[0]
		text = liTag.children[1].children[0].data
		return text.trim().length == 0

	@parse_movies = (moviesTag) ->
		movies = []

		for liTag in select(moviesTag, 'li')
			name = MoviesHelper.parse_movie_name(select(liTag, 'td.name')[0])

			categories = select(liTag, 'td.categoria')

			is3D = MoviesHelper.parse_movie_is_3D(categories[0])
			genre = MoviesHelper.parse_movie_genre(categories[1])

			sessoesTags = select(liTag, 'td.sessoes')
			bodyTags = select(sessoesTags, 'tbody')

			sessions = []

			select(bodyTags, 'tr').forEach (sessionTag) ->
				sessions.push MoviesHelper.parse_movie_session(sessionTag)

			movies.push new Movie(name, genre, is3D, sessions)

		return movies

	@parse_movie_genre = (tdTag) ->
		return tdTag.children[0].data

	@parse_movie_is_3D = (tdTag) ->
		return tdTag.children?

	@parse_movie_name = (tdTag) ->
		h2Tag = select(tdTag, 'h2')[0]
		return h2Tag.children[0].data

	@parse_movie_session = (sessionTag) ->
		room = sessionTag.children[3].children[0].children[0].data.trim()
		room = room.substring(0, room.length - 1)
		times = sessionTag.children[3].children[1].data.split(",")
		type = sessionTag.children[1].children[0].data.trim()

		return new Session(room, type, times)

module.exports = MoviesHelper