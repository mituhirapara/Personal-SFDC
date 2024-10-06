import { LightningElement, api, track } from 'lwc';
import getClaims from '@salesforce/apex/PartnerFundClaimCtrl.getClaims';
import Response from '@salesforce/schema/DeclinedEventRelation.Response';

const cols = [
    {label:"Request Name", fieldName:'Request.Title'}
];

export default class ClaimRecord extends LightningElement {

@api recordId;
@track data=[];
@track columns = cols;

    connectedCallback(){
        getClaims({partnerId : this.recordId})
        .then( response =>{
            if(response) {
                this.data = response;
                console.log("====>>>>> "+ this.data);
            }
        }).catch( error =>{
            console.error("Something went wrong..."+ error);
        })
    }



}