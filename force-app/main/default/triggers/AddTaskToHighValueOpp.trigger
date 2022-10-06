trigger AddTaskToHighValueOpp on Opportunity (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert) {
		HighValueTaskTriggerHelper.onAfterInsert(Trigger.New); 
        OppShareTriggerHelper.onAfterInsert(Trigger.New);   
	}

	if(Trigger.isAfter && Trigger.isUpdate) {
	    HighValueTaskTriggerHelper.onAfterUpdate(Trigger.newMap, Trigger.oldMap);
    }
}

//Create list for tasks
//List<Task> taskList = new List<Task>();
//get opps in trigger
/* for(Opportunity o: [SELECT Id, Amount, CurrencyIsoCode, OwnerId FROM Opportunity WHERE Amount > 7000 AND
Id IN: Trigger.New 
WITH SECURITY_ENFORCED]) {
    if(o.Amount > 10000 && o.CurrencyIsoCode == 'USD') {
        taskList.add(new Task(
        Subject = 'High Value Opportunity Created',
        WhatId = o.Id,
        OwnerId = o.OwnerId,
        Status = 'Not Started',
        ActivityDate = Date.today().addDays(2)));
    } else if (o.Amount > 7000 && o.CurrencyIsoCode == 'GBP') {
        taskList.add(new Task(
        Subject = 'High Value Opportunity Created',
        WhatId = o.Id,
        OwnerId = o.OwnerId,
        Status = 'Not Started',
        ActivityDate = Date.today().addDays(2)));
    } else {
        System.debug('No matching opportunities to process');
    }

    if(taskList.size() > 0) {
        insert taskList;
    }
} */