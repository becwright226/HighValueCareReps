import { LightningElement, api } from 'lwc';

export default class HighValueTaskListItem extends LightningElement {
    @api task;

    handleClick(e) {
        e.preventDefault();
        const selectEvent = new CustomEvent('select', {
            detail: this.task.Id
        });

        this.dispatchEvent(selectEvent);
    }
}