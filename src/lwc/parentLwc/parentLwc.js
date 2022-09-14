import { LightningElement, track } from "lwc";

export default class ParentLwc extends LightningElement {
  @track progressVal = 0;
  hanldeProgressValueChange(event) {
    this.progressVal = event.detail;
  }
}