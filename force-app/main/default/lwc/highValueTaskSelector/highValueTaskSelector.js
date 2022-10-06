import { LightningElement,wire } from 'lwc';
import getHighValueTasks from '@salesforce/apex/TaskController.getHighValueTasks';

export default class HighValueTaskSelector extends LightningElement {
    taskOptions = [];
    error;

    @wire(getHighValueTasks)
    wiredTasks({error, data}) {
        if(data) {
            this.taskOptions = data.map((record) => ({
                value: record.Id,
                label: record.Subject
            }));
            this.error = undefined;
        } else if(error) {
            this.error = error;
            this.taskOptions = undefined;
        }
    }

    handleRecordSelected(event) {
        this.dispatchEvent(
            new CustomEvent('select', {
                detail: { recordId: event.target.value }
            })
        );
    }
}