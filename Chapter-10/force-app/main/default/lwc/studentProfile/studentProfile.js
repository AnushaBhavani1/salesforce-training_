import { LightningElement } from 'lwc';

export default class StudentProfile extends LightningElement {

    studentName = '';
    email = '';
    phone = '';
    cgpa = '';
    branch = '';

    handleChange(event) {
        const field = event.target.dataset.field;
        this[field] = event.target.value;
    }

    handleSave() {

        const inputs = this.template.querySelectorAll('lightning-input');

        let isValid = true;

        inputs.forEach(input => {
            if (!input.reportValidity()) {
                isValid = false;
            }
        });

        if (!isValid) {
            return;
        }

        console.log('Profile saved successfully');
        console.log('Student Name:', this.studentName);
        console.log('Email:', this.email);
        console.log('Phone:', this.phone);
        console.log('CGPA:', this.cgpa);
        console.log('Branch:', this.branch);
    }
}