import { LightningElement, wire  } from 'lwc';
import getHighValueTasks from '@salesforce/apex/TaskController.getHighValueTasks';

export default class HighValueTaskList extends LightningElement {
    @wire(getHighValueTasks)tasks;
///new
    handleSelect(e) {
        e.preventDefault();
        const selectEvent  = new CustomEvent('taskselect', {
            detail:{taskId: e.currentTarget.dataset.taskId}
        });

        this.dispatchEvent(selectEvent);
    }
}