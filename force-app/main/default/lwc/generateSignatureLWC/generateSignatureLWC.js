import { LightningElement,track,api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ATTACHMENT from '@salesforce/schema/Attachment';
import NAME from '@salesforce/schema/Attachment.Name';
import Description from '@salesforce/schema/Attachment.Description';
import PARENTID from '@salesforce/schema/Attachment.ParentId';
import BODY from '@salesforce/schema/Attachment.Body';



export default class GenerateSignatureLWC extends LightningElement {

@track inputSign='';
@track imgSRC="#";
@api recordId;
prevValue='';

handleClick(event){
    let inputElement = this.template.querySelector("input");

    // console.log("signature: "+ inputElement.value);
    


    this.inputSign = inputElement.value;
    let imgElem = this.template.querySelector("img");
    let canvas = this.template.querySelector("canvas"); 
    let context = canvas.getContext("2d"); 
    context.font = "25px Arial Unicode MS";
    if (inputElement.value && inputElement.value != this.prevValue) { 
        context.fillText(inputElement.value, 0, 35); 
        this.prevValue = inputElement.value;
        imgElem.src = canvas.toDataURL('image/png');   
    } 

}

dataURIToBlob(dataURI){
    let binary = atob(dataURI.split(',')[1]), array = [];
    for(var i = 0; i < binary.length; i++) array.push(binary.charCodeAt(i));
    return new Blob([new Uint8Array(array)], {type: image/png});
}

handleFocus(event){
    let canvas = this.template.querySelector("canvas"); 
    let context = canvas.getContext("2d"); 
    context.clearRect(0, 0, canvas.width, canvas.height);
    let imgElem = this.template.querySelector("img");
    imgElem.src = '#'
    console.warn("handleFocus called");
}

}