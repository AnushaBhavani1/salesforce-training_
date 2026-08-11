import { LightningElement, wire } from 'lwc';

import getCurrentStudent from '@salesforce/apex/StudentProfileController.getCurrentStudent';

import {
    updateRecord
} from 'lightning/uiRecordApi';

export default class StudentProfile extends LightningElement {

    student;
    error;
    message;

    isEditing = false;

    editCgpa;
    editBacklogs;
    editDepartment;

    @wire(getCurrentStudent)
    wiredStudent({ data, error }) {

        if (data) {

            this.student = data;
            this.error = undefined;

            console.log('Current Student:', data);
        }

        else if (error) {

            this.student = undefined;

            this.error =
                error?.body?.message ||
                'Unable to load student profile.';

            console.error('Student Error:', error);
        }
    }


    get studentName() {
        return this.student?.Name;
    }


    get cgpa() {
        return this.student?.CGPA__c;
    }


    get activeBacklogs() {
        return this.student?.Active_Backlogs__c;
    }


    get department() {
        return this.student?.Department__c;
    }


    handleEdit() {

        this.editCgpa = this.cgpa;
        this.editBacklogs = this.activeBacklogs;
        this.editDepartment = this.department;

        this.message = undefined;
        this.error = undefined;

        this.isEditing = true;
    }


    handleCgpaChange(event) {
        this.editCgpa = event.target.value;
    }


    handleBacklogsChange(event) {
        this.editBacklogs = event.target.value;
    }


    handleDepartmentChange(event) {
        this.editDepartment = event.target.value;
    }


    handleCancel() {

        this.isEditing = false;

        this.message = undefined;
        this.error = undefined;
    }


    async handleSave() {

        this.message = undefined;
        this.error = undefined;

        const cgpa = Number(this.editCgpa);
        const backlogs = Number(this.editBacklogs);

        // Client-side validation

        if (Number.isNaN(cgpa) || cgpa < 0 || cgpa > 10) {

            this.error = 'CGPA must be between 0 and 10.';
            return;
        }

        if (Number.isNaN(backlogs) || backlogs < 0) {

            this.error = 'Active backlogs cannot be negative.';
            return;
        }

        if (!this.editDepartment) {

            this.error = 'Department is required.';
            return;
        }


        // Update the current Student record

        const fields = {

            Id: this.student.Id,

            CGPA__c: cgpa,

            Active_Backlogs__c: backlogs,

            Department__c: this.editDepartment
        };


        try {

            await updateRecord({ fields });

           this.message = 'Profile updated successfully.';

this.isEditing = false;

// Tell the parent that the profile changed
this.dispatchEvent(
    new CustomEvent('profilesaved')
);
            // Refresh the wire by asking Salesforce for the
            // current student again.
            await this.refreshStudent();

        }

        catch (error) {

            console.error('Update Error:', error);

            this.error =
                error?.body?.message ||
                'Unable to update student profile.';
        }
    }


    async refreshStudent() {

        // The wired Apex method is cacheable.
        // Force the component to reload the current student.
        window.location.reload();
    }
}