function main() {
  var REPORT_NAME = 'Google AdWords Keyword Report';
  var REPORT_TYPE = 'KEYWORDS_PERFORMANCE_REPORT';
  var FILTER = 'Impressions > 0';
  var DATE_RANGE = 'LAST_30_DAYS';
  var COLUMN_NAMES = [
    'Date',
    'Criteria',
    'Status',
    'CampaignName',
    'AdGroupName',
    'CpcBid',
    'Clicks',
    'Impressions',
    'Ctr',
    'AverageCpc',
    'AverageCpm',
    'Cost',
    'AveragePosition',
    'ConvertedClicks',
    'CostPerConvertedClick',
    'ClickConversionRate',
    'Conversions',
    'ViewThroughConversions',
    'QualityScore',
    'ConversionValue',
    'ConvertedClicks',
  ];
  var COLUMNS = COLUMN_NAMES.join(',');
  var REPORT = AdWordsApp.report(
    'SELECT ' + COLUMNS +
    ' FROM ' + REPORT_TYPE +
    ' WHERE Status IN [REMOVED, ENABLED, PAUSED]' +
    ' AND ' + FILTER +
    ' DURING ' + DATE_RANGE
  );
  if (DriveApp.getFilesByName(REPORT_NAME).hasNext()) {
    Logger.log("Overwriting the existing report");
    var file = DriveApp.getFilesByName(REPORT_NAME).next();
    var spreadsheet = SpreadsheetApp.openByUrl(file.getUrl());
  } else {
    Logger.log("Creating a new report");
    var spreadsheet = SpreadsheetApp.create(REPORT_NAME);
  }
  var sheet = spreadsheet.getActiveSheet();
  REPORT.exportToSheet(sheet);
}
