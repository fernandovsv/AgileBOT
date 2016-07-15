# Description:
#   Checks if Agile Promoter System is online
# Commands:
#   hubot <domain> caiu? - Displays status of Agile Promoter System.

options= rejectUnauthorized: false

module.exports = (robot) ->

	robot.respond /((.*) caiu\?)/i, (msg) ->
	    system = msg.match[2]
	    millisStart = new Date().getTime()
	    msg.robot.http("https://#{system}.agilepromoter.com", options).get() (err, res, body) ->
	        if res.statusCode isnt 200
	           msg.reply "Não consegue Moises, deu ruim, run to the hills! `#{system}` está off! codigo http: #{res.statusCode} #{":scream:"}"
	        else
	           millisEnd = new Date().getTime();
	           replyTime = millisEnd - millisStart;
	           if replyTime < 200
	               msg.reply "Caiu nada, `#{system}` está online e está uma bala, BIURLLL!!. Codigo http: #{res.statusCode} #{":metal:"} respondido em #{millisEnd - millisStart} millis"
	           else if replyTime < 1000
	               msg.reply "Caiu nada, `#{system}` está online, BIURLLL!!. Codigo http: #{res.statusCode} #{":metal:"} respondido em #{millisEnd - millisStart} millis"
	           else
	               msg.reply "Não caiu, `#{system}` está online, mas parece que tá meio lentão. Codigo http: #{res.statusCode} #{":metal:"} respondido em #{millisEnd - millisStart} millis"
	               
	               