import { LightningElement, api } from 'lwc';

export default class StudentSummary extends LightningElement {

    @api studentName;
    @api branch;
    @api cgpa;

    handleViewProfile() {

        this.dispatchEvent(
            new CustomEvent('viewprofile')
        );

    }
}