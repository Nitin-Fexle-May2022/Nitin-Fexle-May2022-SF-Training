import { LightningElement} from 'lwc';
import methodOne from '@salesforce/apex/ApexMethodSequence.getTextMethod1';
import methodTwo from '@salesforce/apex/ApexMethodSequence.getTextMethod2';
import methodThree from '@salesforce/apex/ApexMethodSequence.getTextMethod3';

export default class DayTwo extends LightningElement {
    String1;
    String2;
    String3;
    
    handleMethodOne(){
        methodOne()
            .then(result => {
                this.String1 = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleMethodTwo(){
        methodOne()
            .then(result => {
                this.String1 = result;
            })
        methodTwo()
            .then(result => {
                this.String2 = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    handleMethodThree(){
        methodOne()
            .then(result => {
                this.String1 = result;
            })
        methodTwo()
            .then(result => {
                this.String2 = result;
            })
        methodThree()
            .then(result => {
                this.String3 = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    
}