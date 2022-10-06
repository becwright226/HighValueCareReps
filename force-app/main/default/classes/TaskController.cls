public with sharing class TaskController {

    @AuraEnabled(cacheable=true scope='global')
    public static List<Task> getHighValueTasks() {

                return [SELECT Id, Subject, Status, ActivityDate, WhatId , Owner.Name FROM Task WHERE Subject LIKE '%High Value Opportunity Created%'
                WITH SECURITY_ENFORCED
                ORDER BY Subject LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static Task getSingleTask() {
        return [
            SELECT Id, Subject, Status, ActivityDate, WhatId , Owner.Name FROM Task WHERE Subject LIKE '%High Value Opportunity Created%'
                WITH SECURITY_ENFORCED
                ORDER BY Subject LIMIT 1
        ];
    }

    @AuraEnabled
    public static void updateTasks(List<Task> tasksForUpdate) {
        // Make sure we can update the database before trying to update
        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new SecurityException(
                'Insufficient permissions to update tasks'
            );
        }
        update tasksForUpdate;
    }
}
