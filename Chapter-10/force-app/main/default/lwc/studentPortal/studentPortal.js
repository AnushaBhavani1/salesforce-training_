import { LightningElement } from 'lwc';

export default class StudentPortal extends LightningElement {

    applicationSuccess = false;

    handleViewProfile() {
        console.log('View Profile clicked');
    }

    handleJobDetails(event) {
        console.log('Job Details:', event.detail.jobId);
    }

    handleJobApply(event) {
        console.log('StudentPortal received Apply event');

        this.applicationSuccess = true;
    }
}