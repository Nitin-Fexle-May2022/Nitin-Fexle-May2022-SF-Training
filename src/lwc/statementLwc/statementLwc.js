import { LightningElement, api, track} from 'lwc';
import getTransactionDataToExport from '@salesforce/apex/TransactionListViewLwcController.getTransactionDataToExport';
import {loadScript} from 'lightning/platformResourceLoader'
import JSPDF from '@salesforce/resourceUrl/jsPdf';
export default class StatementLwc extends LightningElement {
  
  @api recordId;
  @track startDate;
  @track endDate;
  recordData = {};
  showTable = false;

  columnHeader = [ { label: 'Transaction Name', fieldName: 'Name', type: 'text' },
         { label: 'Transaction Type', fieldName: 'Type__c', type: 'text' },
         { label: 'Transaction Status', fieldName: 'Status__c', type: 'text' },
         { label: 'Transaction Amount', fieldName: 'Amount__c', type: 'Currency'},
         { label: 'Transaction Date', fieldName: 'Transaction_Date__c', type: 'date'}
    ];

  columnHead = ['Transaction', 'Transaction Type', 'Transaction Status', 'Transaction Amount', 'TransactionDate' ];


      /*headers = this.createHeaders([
                                'Name',
                                 'Type__c',
                                    'Status__c',
                                    'Transaction_Date__c'
                                  ]);*/
                                
   
     handleDateChange1(event){
         this.startDate = event.target.value;
            }
    handleDateChange2(event){
         this.endDate = event.target.value;
        }
        handleDisplayRecords(event) {       
        getTransactionDataToExport({conId : this.recordId, startDate : this.startDate, endDate : this.endDate })
        .then(result =>{
                        this.recordData = result;
                        this.showTable = true;
                        console.log('Yes1'+JSON.stringify(this.recordData));
                        
                         })
        .catch(error =>
        {       
                console.log('in catch 4' + JSON.stringify(error.body));
                this.showToastMessage(ERROR, error.body.message,ERROR); 
        });
    }

        handleCsvRecords(event) {
                    // Prepare a html table
                let doc = '<table>';
                // Add styles for the table
                doc += '<style>';
                doc += 'table, th, td {';
                doc += '    border: 1px solid black;';
                doc += '    border-collapse: collapse;';
                doc += '}';          
                doc += '</style>';
                // Add all the Table Headers
                doc += '<tr>';
                this.columnHead.forEach(element => {            
                    doc += '<th>'+ element +'</th>'           
                });
                doc += '</tr>';
                // Add the data rows
                this.recordData.forEach(record => {
                    doc += '<tr>';
                    doc += '<th>'+record.Name+'</th>'; 
                    doc += '<th>'+record.Type__c+'</th>'; 
                    doc += '<th>'+record.Status__c+'</th>';
                    doc += '<th>'+record.Amount__c+'</th>';
                    doc += '<th>'+record.Transaction_Date__c+'</th>'; 
                    doc += '</tr>';
                });
                doc += '</table>';
                var element = 'data:application/vnd.ms-excel,' + encodeURIComponent(doc);
                let downloadElement = document.createElement('a');
                downloadElement.href = element;
                downloadElement.target = '_self';
                // use .csv as extension on below line if you want to export data as csv
                downloadElement.download = 'Contact Data.xls';
                document.body.appendChild(downloadElement);
                downloadElement.click();
             }
             /* generatePdf(){
                const { jsPDF } = window.jspdf;
                const pdf = new jsPDF({
                    encryption: {
                        userPermissions: ["print", "modify", "copy", "annot-forms"]
                    }
                });
          
                console.log(this.dataList);
          
                pdf.text("Transaction Statement", 90, 10);
                pdf.table(10, 20, this.dataList, this.headers, {autosize: true});
                pdf.save("Statement.pdf");
            }

             createHeaders(keys) {
                var result = [];
                for (var i = 0; i < keys.length; i += 1) {
                    result.push({
                        id: keys[i],
                        name: keys[i],
                        prompt: keys[i],
                        width: 65,
                        align: "center",
                        padding: 0
                    });
                }
                return result;
            }

            renderedCallback() {
                Promise.all([
                    loadScript(this, JSPDF)
                ]);
            }
            */
            renderedCallback() {
                Promise.all([
                    loadScript(this, JSPDF)
                ]);
            }
            
              headers = this.createHeaders([
                'Name',
                'Type__c',
                'Status__c',
                'Transaction_Date__c'
              ]);
            
            
              generatePdf(){
                  const { jsPDF } = window.jspdf;
                  const pdf = new jsPDF({
                      encryption: {
                          userPermissions: ["print", "modify", "copy", "annot-forms"]
                      }
                  });
            
                  console.log(this.recordData);
            
                  pdf.text("Transaction Statement", 90, 10);
                  pdf.table(10, 20, this.recordData, this.headers, {autosize: true});
                  pdf.save("Statement.pdf");
              }
            
              downloadDataPdf() {
            
                console.log("download PDF.");
                this.generatePdf();
              }
            
            
              createHeaders(keys) {
                let result = [];
                for (let i = 0; i < keys.length; i += 1) {
                  result.push({
                    id: keys[i],
                    name: keys[i],
                    prompt: keys[i],
                    width: 65,
                    align: "center",
                    padding: 0
                  });
                }
                return result;
              }
    }