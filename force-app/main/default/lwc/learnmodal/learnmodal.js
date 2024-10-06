import getRelatedContactsMap from '@salesforce/apex/AccountController.getRelatedContactsMap';
import { LightningElement, track, api } from 'lwc';

export default class ModalExample extends LightningElement {

    @api recordId;
    @track result;
    error;

    @track openmodel = false;
    
    async connectedCallback() {
        try {
            this.result = await getRelatedContactsMap({accountId: this.recordId});
            console.warn("data: "+ this.result);
            this.error = undefined;
        } catch (error) {
            this.error = error;
            this.result = undefined;
            console.error('Oops error: '+ error);   
        }
    }

    openmodal() {
        this.openmodel = true;
    }
    
    goBack() {
        this.openmodel = false;
    }
}