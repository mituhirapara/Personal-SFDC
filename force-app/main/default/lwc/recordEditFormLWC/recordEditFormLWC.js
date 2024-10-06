import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordEditFormLWC extends LightningElement {

    
    errorClass = 'slds-hide';
    errorMessage;
    @api recordId;

    handleSuccess() {
        const event = new ShowToastEvent({
            title: 'Success',
            message:
                'Lead is Updated successfully !',
        });
        this.dispatchEvent(event);
    }

    handleBlur(event) {
        
        // this.template.querySelectorAll('lightning-input-field').forEach(element =>{
        //     console.log(element.label);
        //     console.log(element.value);

        //      if(element.label == 'RequestedAmount' && element.value < 10) {
        //         element.setCustomValidity("Request Amount cannot be less then 10");
        //     }else{
        //         element.setsetCustomValidity("");
        //     }

        //     element.reportValidity();
        // });
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }   

}