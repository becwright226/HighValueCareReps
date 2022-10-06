import { LightningElement,wire,api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import SUBJECT_FIELD from '@salesforce/schema/Task.Subject';
import STATUS_FIELD from '@salesforce/schema/Task.Status';
import ACTIVITYDATE_FIELD from '@salesforce/schema/Task.ActivityDate';
import OWNER_FIELD from '@salesforce/schema/Task.Owner.Name';

const fields = [
    SUBJECT_FIELD,
    STATUS_FIELD,
    ACTIVITYDATE_FIELD,
    OWNER_FIELD
];

import getHighValueTasks from '@salesforce/apex/TaskController.getHighValueTasks';


export default class HighValueTaskInfo extends LightningElement {
    @api recordId
    @wire(getRecord,{recordId: '$recordId', fields}) task;
    get subject() {
        return getFieldValue(this.task.data, SUBJECT_FIELD);
    }
    get status() {
        return getFieldValue(this.task.data, STATUS_FIELD);
    }
    get activitydate() {
        return getFieldValue(this.task.data, ACTIVITYDATE_FIELD);
    }
    get owner() {
        return getFieldValue(this.task.data, OWNER_FIELD);
    }
}