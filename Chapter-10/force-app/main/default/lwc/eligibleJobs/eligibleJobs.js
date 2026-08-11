import { LightningElement } from 'lwc';

export default class EligibleJobs extends LightningElement {

    jobs = [
        {
            id: '1',
            title: 'Salesforce Developer',
            company: 'Tech Solutions',
            location: 'Hyderabad',
            salary: '5 LPA'
        },
        {
            id: '2',
            title: 'Software Developer',
            company: 'ABC Technologies',
            location: 'Bangalore',
            salary: '6 LPA'
        }
    ];

    get hasJobs() {
        return this.jobs.length > 0;
    }

    handleViewDetails(event) {
        this.dispatchEvent(
            new CustomEvent('viewdetails', {
                detail: {
                    jobId: event.detail.jobId
                }
            })
        );
    }

    handleApply(event) {
        this.dispatchEvent(
            new CustomEvent('apply', {
                detail: {
                    jobId: event.detail.jobId
                }
            })
        );
    }

    handleUpdateProfile() {
        console.log('Update Profile clicked');
    }
}