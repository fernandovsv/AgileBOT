gitFROM mhart/alpine-node

ADD . /app

ENV HUBOT_PORT 8080
ENV GOOGLE_API_KEY AIzaSyBIMIozM8bKGKV6KgwvNN1CEdcjI8x0Udg
ENV HUBOT_GOOGLE_CSE_ID 012549047201097884635:lrunk7ljhec
ENV HUBOT_GOOGLE_CSE_KEY AIzaSyABJ9Y4MizhDqygu3tcfQSFwzheAW68T5s
ENV HUBOT_ADAPTER slack
ENV HUBOT_NAME invbot
ENV HUBOT_SLACK_TOKEN xoxb-19688175236-xpr7u1XQpWoPcOsvTzfnLmNQ
ENV HUBOT_SLACK_TEAM team-name
ENV HUBOT_SLACK_BOTNAME ${HUBOT_NAME}
ENV INVOLVES_CURRENT_REVENUES 6707976
ENV INVOLVES_FIRST_SEMESTER_REVENUES 4777263
ENV INVOLVES_GOAL_REVENUES 16274979
ENV INVOLVES_LAST_YEAR_REVENUES 5424992
ENV INVOLVES_NET_PROFIT 24
ENV INVOLVES_NEXT_MONTH_ESTIMATED_REVENUES 996214
ENV REDIS_URL redis://172.17.0.1:6379/hubot-brain
#Keep alive for slack adapter
HUBOT_SLACK_EXIT_ON_DISCONNECT x

WORKDIR /app
RUN chmod +x /app/bin/hubot

ENTRYPOINT  /app/bin/hubot
