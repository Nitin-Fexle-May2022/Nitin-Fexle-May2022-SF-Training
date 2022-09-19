import { LightningElement, api } from "lwc";

export default class ChildLwc extends LightningElement {
  @api progressVal;
  handleChnage(event) {
    this.progressVal = event.target.value;
    // Creates the event with the data.
    const selectedEvent = new CustomEvent("progressvaluechange", {
      detail: this.progressVal
    });

    // Dispatches the event.
    this.dispatchEvent(selectedEvent);
  }
}