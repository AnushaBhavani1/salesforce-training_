import { LightningElement, wire } from 'lwc';
import getJobs from '@salesforce/apex/EligibleJobsController.getJobs';
import applyForJob from '@salesforce/apex/EligibleJobsController.applyForJob';

export default class EligibleJobs extends LightningElement {

    jobs = [];
    selectedJob;
    error;
    message;

    studentId = 'a00fj000024krimAAA';

    @wire(getJobs)
    wiredJobs({ data, error }) {
        if (data) {
            this.jobs = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.jobs = [];
        }
    }

    handleViewDetails(event) {
        const jobId = event.currentTarget.dataset.id;

        this.selectedJob = this.jobs.find(
            job => job.Id === jobId
        );

        console.log('Selected Job:', this.selectedJob);
    }

    handleApply(event) {
        const jobId = event.currentTarget.dataset.id;

        console.log('Applying for Job:', jobId);
        console.log('Student ID:', this.studentId);

        this.message = 'Submitting application...';
        this.error = undefined;

        applyForJob({
            studentId: this.studentId,
            jobId: jobId
        })
        .then(result => {
            this.message = result;
            this.error = undefined;
            console.log('Application Result:', result);
        })
        .catch(error => {

    console.error('FULL APPLICATION ERROR:', JSON.stringify(error));

    this.message = undefined;

    let errorMessage = 'Unable to submit application.';

    if (error?.body?.message) {
        errorMessage = error.body.message;
    } else if (error?.body?.pageErrors?.length) {
        errorMessage = error.body.pageErrors[0].message;
    } else if (error?.message) {
        errorMessage = error.message;
    }

    this.error = errorMessage;
});
    }
}