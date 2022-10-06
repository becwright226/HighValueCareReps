public with sharing class HighValueTaskTriggerHelper {

   //Add comments for project clarity

   //Specify ares w/ logic- what are you telling the system to do?

   //Identify queries, lists

   
    public static void onAfterInsert(List<Opportunity> oppList) {

        List<Task> taskList = new List<Task>();

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Opportunity o : oppList) {

            if(o.Amount > 10000 && o.CurrencyIsoCode == 'USD'|| o.Amount > 7000 && o.CurrencyIsoCode == 'GBP') {

                taskList.add(new Task(
                Subject = 'High Value Opportunity Created',
                WhatId = o.Id,
                OwnerId = g.Id,//
                Status = 'Not Started',
                ActivityDate = Date.today().addDays(2)));

            } 
            else {
                System.debug('No matching opportunities to process');
            }
        }

        if(taskList.size() > 0) { 
            insert taskList;
        }

    }



    public static void onAfterUpdate(Map<Id, Opportunity> newOppsMap, 
    Map<Id, Opportunity> oldOppsMap) {
  
        List<Task> taskList = new List<Task>();

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Opportunity o: newOppsMap.values()) {

            if(o.Amount > 10000 && o.CurrencyIsoCode == 'USD' || o.Amount > 7000 && o.CurrencyIsoCode == 'GBP' ) {  
                if(o.Amount != oldOppsMap.get(o.Id).Amount && oldOppsMap.get(o.Id).Amount < 10000 && o.CurrencyIsoCode == 'USD') {
                    taskList.add(new Task(
                    Subject = 'High Value Opportunity Created',
                    WhatId = o.Id,
                    OwnerId = g.Id,
                    Status = 'Not Started',
                    ActivityDate = Date.today().addDays(2)));

                } else if(o.Amount != oldOppsMap.get(o.Id).Amount && oldOppsMap.get(o.Id).Amount < 7000 && o.CurrencyIsoCode == 'GBP') {
                    taskList.add(new Task(
                    Subject = 'High Value Opportunity Created',
                    WhatId = o.Id,
                    OwnerId = g.Id,
                    Status = 'Not Started',
                    ActivityDate = Date.today().addDays(2)));
                }     
            }

            if(taskList.size() > 0) {
                insert taskList;
            }  
        }
    }
}
