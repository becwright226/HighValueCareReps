@isTest
private class HighValueTaskTriggerTestClass {
    @isTest 
        static void usdHighValueAfterInsertTest() {
        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-USD',
            StageName='Prospecting',
            Amount=10001,
            CurrencyIsoCode='USD',
            CloseDate=System.today().addMonths(1)
        );

        Test.startTest();
        insert testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];
        system.assertEquals(1, taskList.size(), 'Task List was empty');

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Task t: taskList) {

            system.assertEquals('High Value Opportunity Created', t.Subject, 'No Subject matching expected value');
            system.assertEquals(Date.today().addDays(2), t.ActivityDate, 'Incorrect Date');
            system.assertEquals(g.Id, t.OwnerId, 'Task was not assigned to High Value Reps Queue');
            system.assertEquals(testOpp.Id, t.WhatId, 'Task not related to High Value Opp');

        }
    }

    @isTest 
     static void gbpHighValueAfterInsertTest() {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-GBP',
            StageName='Prospecting',
            Amount=7001,
            CurrencyIsoCode='GBP',
            CloseDate=System.today().addMonths(1)
        );

        Test.startTest();
        insert testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];
        system.assertEquals(1, taskList.size(), 'Task List was empty');

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Task t: taskList) {

            system.assertEquals('High Value Opportunity Created', t.Subject, 'No Subject matching expected value');
            system.assertEquals(Date.today().addDays(2), t.ActivityDate, 'Incorrect Date');
            system.assertEquals(g.Id, t.OwnerId, 'Task was not assigned to High Value Reps Queue');
            system.assertEquals(testOpp.Id, t.WhatId, 'Task not related to High Value Opp');
        } 
     }

     @isTest
     static void usdStandardValueAfterInsert() {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-USD',
            StageName='Prospecting',
            Amount=10000,
            CurrencyIsoCode='USD',
            CloseDate=System.today().addMonths(1)
        );

        Test.startTest();
        insert testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];
        system.assertEquals(0, taskList.size(), 'Task was created');

     }

     @isTest
     static void gbpStandardValueAfterInsert() {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-GBP',
            StageName='Prospecting',
            Amount=7000,
            CurrencyIsoCode='GBP',
            CloseDate=System.today().addMonths(1)
        );

        Test.startTest();
        insert testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];
        system.assertEquals(0, taskList.size(), 'Task was created');

     }

     @isTest
     static void usdStandardToHighValueOnAfterUpdate () {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-USD',
            StageName='Prospecting',
            Amount=9999,
            CurrencyIsoCode='USD',
            CloseDate=System.today().addMonths(1)
        );

        insert testOpp;

        List<Task> oldTaskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(0, oldTaskList.size(), 'Task was created');

        Test.startTest();
        testOpp.Amount = 10001;
        update testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, taskList.size(), 'Task was not created');

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Task t: taskList) {

            system.assertEquals('High Value Opportunity Created', t.Subject, 'No Subject matching expected value');
            system.assertEquals(Date.today().addDays(2), t.ActivityDate, 'Incorrect Date');
            system.assertEquals(g.Id, t.OwnerId, 'Task was not assigned to High Value Reps Queue');
            system.assertEquals(testOpp.Id, t.WhatId, 'Task not related to High Value Opp');
        } 


     }

     @isTest
     static void gbpStandardToHighValueOnAfterUpdate () {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-GBP',
            StageName='Prospecting',
            Amount=6999,
            CurrencyIsoCode='GBP',
            CloseDate=System.today().addMonths(1)
        );
        
        insert testOpp;

        List<Task> oldTaskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(0, oldTaskList.size(), 'Task was created');

        Test.startTest();
        testOpp.Amount = 7001;
        update testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, taskList.size(), 'Task was not created');

        Group g = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Queue' WITH SECURITY_ENFORCED LIMIT 1];

        for(Task t: taskList) {

            system.assertEquals('High Value Opportunity Created', t.Subject, 'No Subject matching expected value');
            system.assertEquals(Date.today().addDays(2), t.ActivityDate, 'Incorrect Date');
            system.assertEquals(g.Id, t.OwnerId, 'Task was not assigned to High Value Reps Queue');
            system.assertEquals(testOpp.Id, t.WhatId, 'Task not related to High Value Opp');
        } 


     }

     @isTest
     static void usdHighToHigherValueOnAfterUpdate () {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-USD',
            StageName='Prospecting',
            Amount=19999,
            CurrencyIsoCode='USD',
            CloseDate=System.today().addMonths(1)
        );

        insert testOpp;

        List<Task> oldTaskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, oldTaskList.size(), 'Task was found');

        Test.startTest();
        testOpp.Amount = 100001;
        update testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, taskList.size(), 'New High Value Task was not created');

     }

     @isTest
     static void gbpHighToHigherValueOnAfterUpdate () {

        Opportunity testOpp  = new Opportunity(
            Name='Test Opp-Apex-GBP',
            StageName='Prospecting',
            Amount=19999,
            CurrencyIsoCode='GBP',
            CloseDate=System.today().addMonths(1)
        );

        insert testOpp;

        List<Task> oldTaskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, oldTaskList.size(), 'Task was found');

        Test.startTest();
        testOpp.Amount = 100001;
        update testOpp;
        Test.stopTest();

        List<Task> taskList = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status FROM Task WHERE WhatId =: testOpp.Id];

        system.assertEquals(1, taskList.size(), 'New High Value Task was not created');

     }

}
