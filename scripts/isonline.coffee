# Description:
#   Checks if Agile Promoter System is online
# Commands:
#   hubot <domain> caiu? - Displays status of Agile Promoter System.

channels = [
  "dev",
  "mobile",
  "agile-ios",
  "general",
  "canaldobot",
  "Shell",
  "agile-infra",
  "agile-suporte",
  "sucesso"
]
options= rejectUnauthorized: false

module.exports = (robot) ->

	robot.respond /((.*) caiu\?)/i, (msg) ->
		system = msg.match[2]
  msg.robot.http("https://#{system}.agilepromoter.com", options).get() (err, res, body) ->
      if res.statusCode isnt 200
         msg.reply "Não consegue Moises,deu ruim, run to the hills codigo http: #{res.statusCode} #{":scream:"}"
      else
         msg.reply "Caiu nada está online, BIURLLL!!. Codigo http: #{res.statusCode} #{":metal:"}"
