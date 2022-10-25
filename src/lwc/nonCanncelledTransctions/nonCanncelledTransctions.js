import { LightningElement, api, track } from 'lwc';
import getTransactionEntries from '@salesforce/apex/TransactionListViewLwcController.getTransactionEntries';
import model from '@salesforce/resourceUrl/Model';
import { loadStyle} from 'lightning/platformResourceLoader';



const transactionTableColumn = [ { label: 'Transaction Name', fieldName: 'Name', type: 'url' },
                                 { label: 'Transaction Type', fieldName: 'Type__c', type: 'text' },
                                  { label: 'Transaction Status', fieldName: 'Status__c', type: 'Text' },
                                   { label: 'Transaction Amount', fieldName: 'Amount__c', type: 'currency'}
                                   ];
const recordLimitOption = [ { label: '5', value: 5 }, {label: '10', value: 10 },
{ label: '15', value: 15 }, {label: '20', value: 20 }, {label: '25', value: 25 }];
export default class NonCanncelledTransctions extends LightningElement {
    selectedRecordLimits;
    @track records = {};
    @api recordId;
    showTable = false;
    colomn = transactionTableColumn;
    
     get recordLimitOption() {
        return [ { label: '5', value: 5 }, {label: '10', value: 10 },
                 { label: '15', value: 15 }, {label: '20', value: 20 },
                 {label: '25', value: 25 }];
                 }

    handleRecordLimitChange(event) {
        
        this.selectedRecordLimits = event.target.value;
        getTransactionEntries({conId : this.recordId, selectedRecordLimits : this.selectedRecordLimits })
        .then(result =>{
                        this.records = result;
                        this.showTable = true;
                        console.log('Yes2'+JSON.stringify(this.records));
                        
                         })
        .catch(error =>
        {       
                console.log('in catch 4' + JSON.stringify(error.body));
                this.showToastMessage(ERROR, error.body.message,ERROR); 
        });
        console.log('Yes2'+JSON.stringify(this.records));
    }
    connectedCallback() {

               Promise.all([
                    loadStyle(this, model)
                ])
         }
        
        
}