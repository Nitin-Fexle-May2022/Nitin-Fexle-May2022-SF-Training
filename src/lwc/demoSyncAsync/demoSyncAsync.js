import { LightningElement} from 'lwc';
import methodOne from '@salesforce/apex/ApexMethodSequence.getTextMethod1';
import methodTwo from '@salesforce/apex/ApexMethodSequence.getTextMethod2';
import methodThree from '@salesforce/apex/ApexMethodSequence.getTextMethod3';

export default class DemoSyncAsync extends LightningElement {
    String1;
    String2;
    String3;
    
    async handleOnlick() {
        try {
            this.String1 = await methodOne();
            this.String2 = await methodTwo();
            this.String3 = await methodThree();
        } catch(error) {
            console.error(error);
        } finally {
            console.log('Finally Block');
        }
    }
    
}