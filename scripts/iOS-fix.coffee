# Description
#	Fix iOS typo

channels = [
  "dev",
  "mobile",
  "agile-ios",
  "general",
  "canaldobot",
  "Shell"
]

module.exports = (robot) ->

	robot.hear /\bios\b/gi, (res) ->
		channelName = res.message.room
		urlRegex = '^(?!mailto:)(?:(?:http|https|ftp)://)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$'
		regex = new RegExp(urlRegex, 'i')
		isURL = res.message.text.length < 2083 && regex.test(res.message.text)

		if (!isURL and channelName in channels)
			count = 0
			for text in res.match
				if text isnt "iOS"
					count += 1

			if count != 0
				dbCount = robot.brain.get('dolphin_killed_count') + count
				robot.brain.set('dolphin_killed_count', dbCount)
				res.send "Você acabou de matar #{":dagger_knife:"} #{count} #{":dolphin:"} ao escrever \"iOS\" errado. Golfinhos mortos: #{dbCount}"