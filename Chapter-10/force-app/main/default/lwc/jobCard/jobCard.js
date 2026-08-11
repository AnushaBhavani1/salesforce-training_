import { LightningElement, api } from 'lwc';

export default class JobCard extends LightningElement {

    @api job;

    handleViewDetails() {
        this.dispatchEvent(
            new CustomEvent('viewdetails', {
                bubbles: true,
                composed: true,
                detail: {
                    jobId: this.job.id
                }
            })
        );
    }

    handleApply() {
        this.dispatchEvent(
            new CustomEvent('apply', {
                bubbles: true,
                composed: true,
                detail: {
                    jobId: this.job.id
                }
            })
        );
    }
}