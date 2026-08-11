import { LightningElement } from 'lwc';
import logo from '@salesforce/resourceUrl/vishnuLogo';

export default class PlacementHome extends LightningElement {

    logoUrl = logo;

    studentName = 'Anusha';
    rollNumber = '23PA1A1201';
    department = 'Information Technology';

    message = '';
    status = 'Not Applied';

    showMessage() {
        this.message = 'Welcome to Salesforce Development!';
    }

    apply() {
        this.status = 'Applied';
    }
}