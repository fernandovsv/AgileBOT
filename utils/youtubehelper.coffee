http = require('https')

class YoutubeHelper
	@API_KEY = ""

	@search_trailer = (movieName, callback) ->
		query = encodeURI(movieName + " trailer")
		url = "https://www.googleapis.com/youtube/v3/search?part=id&q=#{query}&type=video&key=#{@API_KEY}"

		req = http.get url, (res) ->
			status = res.statusCode
			if status != 200
				throw "Não consegui pegar o trailer! So sorry!"
			else
				body = ""

				res.on 'end', ->
					json = JSON.parse body
					firstTrailer = json["items"][0]
					videoId = firstTrailer["id"]["videoId"]

					callback "https://www.youtube.com/watch?v=#{videoId}"

				res.on 'data', (chunk) ->
					body = body + chunk

		req.on 'error', ->
			throw "Sem internet?!"




module.exports = YoutubeHelper