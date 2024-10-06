import { LightningElement, track, wire } from 'lwc';
import getAccountByName from '@salesforce/apex/AccountController.getAccountByName';

export default class ParentForm extends LightningElement {
    @track name;

    @track searchKey='Deloitte';
    accounts = [];
    col = [
        { label: 'Account ID', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' }
    ];
    error = undefined;

    @wire(getAccountByName, { searchKey: '$searchKey' })
    wiredAccountByNameResult({ error, data }) {
        if (data) {
            this.error = undefined;
            this.accounts = data;
        } else {
            this.accounts = [];
            this.error = error;
        }
    }

    handleNameChange(event) {
        this.searchKey = event.target.value;
    }
}
