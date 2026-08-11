public with sharing class CandidateSyncQueueable
    implements Queueable, Database.AllowsCallouts {

    private Id applicationId;

    public CandidateSyncQueueable(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        // =====================================================
        // 1. Get Application + Student + Job
        // =====================================================

        Application__c app = [
            SELECT Id,
                   Status__c,
                   Student__c,
                   Student__r.Name,
                   Student__r.Email__c,
                   Student__r.Department__c,
                   Student__r.CGPA__c,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company_Name__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];


        // =====================================================
        // 2. Only process Selected applications
        // =====================================================

        if (app.Status__c != 'Selected') {
            return;
        }


        // =====================================================
        // 3. Build Candidate JSON
        // =====================================================

        Map<String, Object> candidate =
            new Map<String, Object>();

        candidate.put(
            'applicationId',
            app.Id
        );

        candidate.put(
            'studentId',
            app.Student__c
        );

        candidate.put(
            'name',
            app.Student__r.Name
        );

        candidate.put(
            'email',
            app.Student__r.Email__c
        );

        candidate.put(
            'department',
            app.Student__r.Department__c
        );

        candidate.put(
            'cgpa',
            app.Student__r.CGPA__c
        );

        candidate.put(
            'jobId',
            app.Job__c
        );

        candidate.put(
            'company',
            app.Job__r.Company_Name__c
        );

        candidate.put(
            'role',
            app.Job__r.Name
        );

        candidate.put(
            'selectionDate',
            String.valueOf(Date.today())
        );


        // =====================================================
        // 4. Create HTTP Request
        // =====================================================

        HttpRequest request =
            new HttpRequest();

        request.setEndpoint(
            'callout:Placement_Recruitment_API/posts'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        request.setTimeout(10000);

        request.setBody(
            JSON.serialize(candidate)
        );


        // =====================================================
        // 5. Perform Callout
        // =====================================================

        Http http = new Http();

        try {

            HttpResponse response =
                http.send(request);

            Integer statusCode =
                response.getStatusCode();

            String responseBody =
                response.getBody();


            System.debug(
                'Recruitment API Status: ' +
                statusCode
            );

            System.debug(
                'Recruitment API Response: ' +
                responseBody
            );


            // =================================================
            // SUCCESS
            // =================================================

            if (
                statusCode == 200 ||
                statusCode == 201 ||
                statusCode == 204
            ) {

                app.Integration_Status__c =
                    'Sent';

                app.Integration_Error__c =
                    null;

                app.Last_Integration_Attempt__c =
                    System.now();


                // JSONPlaceholder returns an id
                if (
                    statusCode != 204 &&
                    String.isNotBlank(responseBody)
                ) {

                    try {

                        Map<String, Object> responseData =
                            (Map<String, Object>)
                            JSON.deserializeUntyped(
                                responseBody
                            );

                        if (
                            responseData.containsKey('id')
                        ) {

                            app.External_Candidate_Id__c =
                                String.valueOf(
                                    responseData.get('id')
                                );
                        }

                    } catch (Exception parseError) {

                        System.debug(
                            'Response parsing error: ' +
                            parseError.getMessage()
                        );
                    }
                }
            }


            // =================================================
            // BAD REQUEST
            // =================================================

            else if (statusCode == 400) {

                app.Integration_Status__c =
                    'Failed';

                app.Integration_Error__c =
                    'Bad Request: ' +
                    responseBody;

                app.Last_Integration_Attempt__c =
                    System.now();
            }


            // =================================================
            // AUTHENTICATION FAILURE
            // =================================================

            else if (statusCode == 401) {

                app.Integration_Status__c =
                    'Failed';

                app.Integration_Error__c =
                    'Authentication failed: ' +
                    responseBody;

                app.Last_Integration_Attempt__c =
                    System.now();
            }


            // =================================================
            // FORBIDDEN
            // =================================================

            else if (statusCode == 403) {

                app.Integration_Status__c =
                    'Failed';

                app.Integration_Error__c =
                    'Forbidden: ' +
                    responseBody;

                app.Last_Integration_Attempt__c =
                    System.now();
            }


            // =================================================
            // SERVER ERROR
            // =================================================

            else if (statusCode >= 500) {

                app.Integration_Status__c =
                    'Retry Required';

                app.Integration_Error__c =
                    'External server error: ' +
                    responseBody;

                app.Last_Integration_Attempt__c =
                    System.now();
            }


            // =================================================
            // UNEXPECTED RESPONSE
            // =================================================

            else {

                app.Integration_Status__c =
                    'Failed';

                app.Integration_Error__c =
                    'Unexpected HTTP status ' +
                    statusCode +
                    ': ' +
                    responseBody;

                app.Last_Integration_Attempt__c =
                    System.now();
            }


            // =================================================
            // 6. Update Salesforce AFTER Callout
            // =================================================

            update app;

        } catch (Exception e) {

            System.debug(
                'Candidate Sync Error: ' +
                e.getMessage()
            );


            // =================================================
            // Callout failed
            // =================================================

            app.Integration_Status__c =
                'Retry Required';

            app.Last_Integration_Attempt__c =
                System.now();

            app.Integration_Error__c =
                e.getMessage();


            // DML happens AFTER the callout attempt
            update app;
        }
    }
}