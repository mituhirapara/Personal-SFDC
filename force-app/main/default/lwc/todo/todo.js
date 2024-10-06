import { LightningElement, track } from 'lwc';

export default class Todo extends LightningElement {
 
    handleSelected(event) {
        console.log('OUTPUT : ', JSON.parse(JSON.stringify(event.detail)));
    }

}