import { LightningElement,api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';

import getMyApplications
    from '@salesforce/apex/MyApplicationsController.getMyApplications';

export default class MyApplications extends LightningElement {

    applications = [];
    error;
    isLoading = true;

    wiredApplicationsResult;

    @wire(getMyApplications)
    wiredApplications(result) {

        this.wiredApplicationsResult = result;

        const { data, error } = result;

        this.isLoading = false;

        if (data) {

            this.applications = data;
            this.error = undefined;

            console.log(
                'My Applications:',
                JSON.stringify(data)
            );

        } else if (error) {

            this.applications = [];

            this.error =
                error?.body?.message ||
                'Unable to load applications.';

            console.error(
                'Application Error:',
                error
            );
        }
    }

    get hasApplications() {

        return this.applications &&
               this.applications.length > 0;
    }

    // Refresh applications
    @api
    async refreshApplications() {

        if (this.wiredApplicationsResult) {

            this.isLoading = true;

            try {

                await refreshApex(
                    this.wiredApplicationsResult
                );

            } catch (error) {

                this.error =
                    error?.body?.message ||
                    'Unable to refresh applications.';

            } finally {

                this.isLoading = false;
            }
        }
    }
}