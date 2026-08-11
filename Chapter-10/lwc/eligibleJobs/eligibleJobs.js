import { LightningElement, wire } from 'lwc';

import getJobs
    from '@salesforce/apex/EligibleJobsController.getJobs';

import applyForJob
    from '@salesforce/apex/EligibleJobsController.applyForJob';

import getCurrentStudent
    from '@salesforce/apex/StudentProfileController.getCurrentStudent';


export default class EligibleJobs extends LightningElement {

    // =====================================================
    // Properties
    // =====================================================

    jobs = [];

    selectedJob;

    studentId;

    error;

    message;


    // =====================================================
    // Get Current Student
    // =====================================================

    @wire(getCurrentStudent)
    wiredStudent({ data, error }) {

        if (data) {

            this.studentId = data.Id;

            console.log(
                'Current Student:',
                data
            );

            console.log(
                'Current Student ID:',
                data.Id
            );

        }
        else if (error) {

            this.studentId = undefined;

            this.error =
                error?.body?.message ||
                'Unable to load current student.';

            console.error(
                'Student Error:',
                error
            );
        }
    }


    // =====================================================
    // Get Jobs
    // =====================================================

    @wire(getJobs)
    wiredJobs({ data, error }) {

        if (data) {

            this.jobs = data;

            this.error = undefined;

            console.log(
                'Jobs received:',
                data
            );

        }
        else if (error) {

            this.jobs = [];

            this.error =
                error?.body?.message ||
                'Unable to load jobs.';

            console.error(
                'Error loading jobs:',
                error
            );
        }
    }


    // =====================================================
    // View Job Details
    // =====================================================

    handleViewDetails(event) {

        const jobId =
            event.detail.jobId;

        console.log(
            'View Details Job ID:',
            jobId
        );


        this.selectedJob =
            this.jobs.find(
                job => job.Id === jobId
            );


        console.log(
            'Selected Job:',
            this.selectedJob
        );
    }


    // =====================================================
    // Apply For Job
    // =====================================================

    handleApply(event) {

        const jobId =
            event.detail.jobId;


        console.log(
            'Applying for Job:',
            jobId
        );


        console.log(
            'Current Student ID:',
            this.studentId
        );


        // -------------------------------------------------
        // Validate Student
        // -------------------------------------------------

        if (!this.studentId) {

            this.error =
                'Student information is not available.';

            this.message = undefined;

            return;
        }


        // -------------------------------------------------
        // Validate Job
        // -------------------------------------------------

        if (!jobId) {

            this.error =
                'Job ID is missing.';

            this.message = undefined;

            return;
        }


        // -------------------------------------------------
        // Loading
        // -------------------------------------------------

        this.message =
            'Submitting application...';

        this.error = undefined;


        // -------------------------------------------------
        // Call Apex
        // -------------------------------------------------

        applyForJob({

            studentId:
                this.studentId,

            jobId:
                jobId

        })

        .then(result => {

            console.log(
                'Application Result:',
                result
            );


            this.message =
                result;

            this.error =
                undefined;


            // -------------------------------------------------
            // Application Created Successfully
            // -------------------------------------------------

            if (
                result ===
                'Application submitted successfully.'
            ) {

                console.log(
                    'Application created successfully.'
                );


                // Notify parent component
                this.dispatchEvent(
                    new CustomEvent(
                        'applicationcreated',
                        {
                            detail: {
                                jobId: jobId
                            },

                            bubbles: true,

                            composed: true
                        }
                    )
                );


                console.log(
                    'applicationcreated event dispatched.'
                );
            }

        })


        .catch(error => {

            console.error(
                'Application Error:',
                error
            );


            this.message =
                undefined;


            this.error =
                error?.body?.message ||
                'Unable to submit application.';
        });
    }
}