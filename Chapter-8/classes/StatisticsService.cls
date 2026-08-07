public with sharing class StatisticsService {

    public static void updatePlacementStatistics(){

        System.debug('Placement statistics updated.');

    }
    public static void monitorJobs(){

    List<AsyncApexJob> jobs = [

        SELECT Id,
               Status,
               JobType,
               NumberOfErrors,
               TotalJobItems,
               JobItemsProcessed

        FROM AsyncApexJob

        ORDER BY CreatedDate DESC

        LIMIT 5

    ];

    System.debug(jobs);

}
}