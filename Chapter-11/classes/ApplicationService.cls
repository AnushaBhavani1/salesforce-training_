public with sharing class ApplicationService {

    // =========================================================
    // Submit Application
    // =========================================================
    public static String submitApplication(Id studentId, Id jobId) {

        if (studentId == null) {
            return 'Student ID is required.';
        }

        if (jobId == null) {
            return 'Job ID is required.';
        }

        // Get Student
        Student__c student = getStudent(studentId);

        if (student == null) {
            return 'Student not found.';
        }

        // Get Job
        Job__c job = getJob(jobId);

        if (job == null) {
            return 'Job not found.';
        }

        // =====================================================
        // 1. Deadline
        // =====================================================
        if (
            job.Last_Date__c != null &&
            Date.today() > job.Last_Date__c
        ) {
            return 'Application deadline has passed.';
        }

        // =====================================================
        // 2. CGPA
        // =====================================================
        if (job.Minimum_CGPA__c != null) {

            if (student.CGPA__c == null) {
                return 'Student is not eligible. Student CGPA is not available.';
            }

            if (student.CGPA__c < job.Minimum_CGPA__c) {
                return 'Student is not eligible. CGPA is below the minimum requirement.';
            }
        }

        // =====================================================
        // 3. Active Backlogs
        // =====================================================
        if (job.Allowed_Backlogs__c != null) {

            if (student.Active_Backlogs__c == null) {
                return 'Student is not eligible. Active backlog information is not available.';
            }

            if (
                student.Active_Backlogs__c >
                job.Allowed_Backlogs__c
            ) {
                return 'Student is not eligible. Too many active backlogs.';
            }
        }

        // =====================================================
        // 4. Department / Eligible Branch
        // =====================================================
        if (String.isNotBlank(job.Eligible_Branch__c)) {

            if (String.isBlank(student.Department__c)) {
                return 'Student is not eligible. Student department is not available.';
            }

            String studentDepartment =
                student.Department__c.trim().toLowerCase();

            String eligibleBranch =
                job.Eligible_Branch__c.trim().toLowerCase();

            if (studentDepartment != eligibleBranch) {
                return 'Student is not eligible. Student department is not eligible.';
            }
        }

        // =====================================================
        // 5. Duplicate Application
        // =====================================================
        if (isDuplicate(studentId, jobId)) {
            return 'Application already exists.';
        }

        // =====================================================
        // 6. Create Application
        // =====================================================
        Application__c app = new Application__c(
            Student__c = studentId,
            Job__c = jobId,
            Application_Date__c = Date.today(),
            Status__c = 'Applied'
        );

        try {

            insert app;

            return 'Application submitted successfully.';

        } catch (DmlException e) {

            return e.getDmlMessage(0);
        }
    }


    // =========================================================
    // Update Application Status
    // =========================================================
    public static String updateApplicationStatus(
        Id applicationId,
        String newStatus
    ) {

        if (applicationId == null) {
            return 'Application ID is required.';
        }

        if (String.isBlank(newStatus)) {
            return 'Application status is required.';
        }

        List<Application__c> applications = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :applicationId
            LIMIT 1
        ];

        if (applications.isEmpty()) {
            return 'Application not found.';
        }

        Application__c app = applications[0];

        app.Status__c = newStatus;

        update app;

        return 'Application status updated successfully.';
    }


    // =========================================================
    // Get Student
    // =========================================================
    public static Student__c getStudent(Id studentId) {

        if (studentId == null) {
            return null;
        }

        List<Student__c> students = [
            SELECT Id,
                   Name,
                   CGPA__c,
                   Active_Backlogs__c,
                   Department__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        return students.isEmpty()
            ? null
            : students[0];
    }


    // =========================================================
    // Get Job
    // =========================================================
    public static Job__c getJob(Id jobId) {

        if (jobId == null) {
            return null;
        }

        List<Job__c> jobs = [
            SELECT Id,
                   Name,
                   Minimum_CGPA__c,
                   Last_Date__c,
                   Allowed_Backlogs__c,
                   Eligible_Branch__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        return jobs.isEmpty()
            ? null
            : jobs[0];
    }


    // =========================================================
    // Duplicate Check
    // =========================================================
    public static Boolean isDuplicate(
        Id studentId,
        Id jobId
    ) {

        if (studentId == null || jobId == null) {
            return false;
        }

        Integer countApp = [
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        return countApp > 0;
    }


    // =========================================================
    // Trigger Validation
    // =========================================================
    public static void validateApplications(
        List<Application__c> applications
    ) {

        Set<Id> studentIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();

        for (Application__c app : applications) {

            if (app.Student__c != null) {
                studentIds.add(app.Student__c);
            }

            if (app.Job__c != null) {
                jobIds.add(app.Job__c);
            }
        }


        // =====================================================
        // Get Students
        // =====================================================
        Map<Id, Student__c> students =
            new Map<Id, Student__c>([
                SELECT Id,
                       CGPA__c,
                       Active_Backlogs__c,
                       Department__c
                FROM Student__c
                WHERE Id IN :studentIds
            ]);


        // =====================================================
        // Get Jobs
        // =====================================================
        Map<Id, Job__c> jobs =
            new Map<Id, Job__c>([
                SELECT Id,
                       Minimum_CGPA__c,
                       Allowed_Backlogs__c,
                       Eligible_Branch__c,
                       Last_Date__c
                FROM Job__c
                WHERE Id IN :jobIds
            ]);


        // =====================================================
        // Validate
        // =====================================================
        for (Application__c app : applications) {

            Student__c student =
                students.get(app.Student__c);

            Job__c job =
                jobs.get(app.Job__c);


            // Student validation
            if (student == null) {

                app.addError('Student not found.');

                continue;
            }


            // Job validation
            if (job == null) {

                app.addError('Job not found.');

                continue;
            }


            // =================================================
            // Deadline
            // =================================================
            if (
                job.Last_Date__c != null &&
                Date.today() > job.Last_Date__c
            ) {

                app.addError(
                    'Application deadline has passed.'
                );
            }


            // =================================================
            // CGPA
            // =================================================
            if (job.Minimum_CGPA__c != null) {

                if (student.CGPA__c == null) {

                    app.addError(
                        'Student CGPA is not available.'
                    );

                } else if (
                    student.CGPA__c <
                    job.Minimum_CGPA__c
                ) {

                    app.addError(
                        'CGPA is below the minimum requirement.'
                    );
                }
            }


            // =================================================
            // Backlogs
            // =================================================
            if (job.Allowed_Backlogs__c != null) {

                if (student.Active_Backlogs__c == null) {

                    app.addError(
                        'Student active backlog information is not available.'
                    );

                } else if (
                    student.Active_Backlogs__c >
                    job.Allowed_Backlogs__c
                ) {

                    app.addError(
                        'Too many active backlogs.'
                    );
                }
            }


            // =================================================
            // Department / Eligible Branch
            // =================================================
            if (String.isNotBlank(job.Eligible_Branch__c)) {

                if (
                    String.isBlank(student.Department__c)
                ) {

                    app.addError(
                        'Student department is not available.'
                    );

                } else {

                    String studentDepartment =
                        student.Department__c
                            .trim()
                            .toLowerCase();

                    String eligibleBranch =
                        job.Eligible_Branch__c
                            .trim()
                            .toLowerCase();

                    if (
                        studentDepartment !=
                        eligibleBranch
                    ) {

                        app.addError(
                            'Student department is not eligible.'
                        );
                    }
                }
            }
        }
    }


    // =========================================================
    // Handle Status Updates
    // =========================================================
    public static void handleStatusUpdates(
        List<Application__c> newList,
        Map<Id, Application__c> oldMap
    ) {

        System.debug(
            '=== HANDLE STATUS UPDATE START ==='
        );

        for (Application__c app : newList) {

            Application__c oldApp =
                oldMap.get(app.Id);

            System.debug(
                'Old Status: ' +
                oldApp.Status__c
            );

            System.debug(
                'New Status: ' +
                app.Status__c
            );


            if (
                oldApp.Status__c != app.Status__c &&
                app.Status__c == 'Selected'
            ) {

                System.debug(
                    'STATUS CHANGED TO SELECTED'
                );

                System.enqueueJob(
                    new OfferProcessingJob(app.Id)
                );
            }
        }

        System.debug(
            '=== HANDLE STATUS UPDATE END ==='
        );
    }
}