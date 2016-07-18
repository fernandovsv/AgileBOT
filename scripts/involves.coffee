# Description:
#   Checks if Agile Promoter System is online
# Commands:
#   hubot plr - Displays the current PLR status

options= rejectUnauthorized: false
NumberHelper = require('../utils/numberhelpers')
currencyOptions = {
             separator: '.',
             delimiter: '.',
             unit: 'R$'
         }
module.exports = (robot) ->

    robot.hear /plr/i, (res) ->
        
         lastYearRevenue = new Number(process.env.INVOLVES_LAST_YEAR_REVENUES)
         firstSemesterRevenues = new Number(process.env.INVOLVES_FIRST_SEMESTER_REVENUES)       
         currentRevenues =  new Number(process.env.INVOLVES_CURRENT_REVENUES)
         goalRevenues = new Number(process.env.INVOLVES_GOAL_REVENUES)
         nextMonthEstimatedRevenues = new Number(process.env.INVOLVES_NEXT_MONTH_ESTIMATED_REVENUES)
         currentProfitPercentage =  new Number(process.env.INVOLVES_NET_PROFIT)
         
         currentMonth = new Date().getMonth()
         monthsLeft = 12 - currentMonth
         revenuesEstimated = (monthsLeft * nextMonthEstimatedRevenues) + currentRevenues;
            
         goalAchieved =  (revenuesEstimated /  lastYearRevenue * 100);
    
         plrPercentage = 8;
         nextLevelRevenue = 0;
                  
         if (goalAchieved < 203.8)
             plrPercentage = 8 
             nextLevelRevenue =  lastYearRevenue    * 2.038        
         else if (goalAchieved < 250)
             plrPercentage = 9 
             nextLevelRevenue =  lastYearRevenue    * 2.5                       
         else if (goalAchieved < 275)
             plrPercentage = 10 
             nextLevelRevenue =  lastYearRevenue    * 2.75  
         else if (goalAchieved < 300)
             plrPercentage = 11   
             nextLevelRevenue =  lastYearRevenue    * 3  
         else
             plrPercentage = 12
             nextLevelRevenue = lastYearRevenue    * 4
             
                    
         goalPercentage = (revenuesEstimated / goalRevenues) * 100 
         revenueNextLevelLeft  = nextLevelRevenue - revenuesEstimated  
         
         plrValueEstimated = (revenuesEstimated - firstSemesterRevenues) * (plrPercentage/100) * (currentProfitPercentage/100) 
         
         res.reply "Nossa estimativa de faturamento para este ano é de #{NumberHelper.number_to_currency(revenuesEstimated, currencyOptions)}, se mantivermos a lucratividade de #{currentProfitPercentage.toFixed(0)}% 
nosso PLR será de #{plrPercentage.toFixed(0)}% do lucro liquido, o que equivale a #{NumberHelper.number_to_currency(plrValueEstimated, currencyOptions)}. Já atingimos #{goalPercentage.toFixed(2)}% da meta de triplicar e para atingir o próximo nível da 
PLR (#{plrPercentage + 1}% do lucro liquido) precisamos faturar mais #{NumberHelper.number_to_currency(revenueNextLevelLeft, currencyOptions)}. Vom dalhe, POUURRA?"
    

