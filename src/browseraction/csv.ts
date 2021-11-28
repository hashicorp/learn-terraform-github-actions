import {createObjectCsvStringifier} from 'csv-writer'
import { ObjectStringifierHeader } from 'csv-writer/src/lib/record';
import { browser } from 'webextension-polyfill-ts';

let csvStringifier = createObjectCsvStringifier({
  header: [
    {id: 'kw', title: 'Keyword'},
    {id: 'ads', title: '#Ads'},
    {id: 'websites', title: 'Websites'},
    {id: 'domains', title: 'Domains'}
  ]
});

export class CsvBuilder {
  records = []
  constructor(header? : ObjectStringifierHeader) {
    if (header) {
      csvStringifier = createObjectCsvStringifier({
        header
      })
    }
  }

  addRecord(record : any): void {
    this.records.push(record)
  }

  toBlob() {
   return new Blob([csvStringifier.getHeaderString().concat(csvStringifier.stringifyRecords(this.records))], { type: 'text/csv;charset=utf-8;' });
  }

  downloadCsv(filename?: string) {
    function onStartedDownload(id) {
      console.log(`Started downloading: ${id}`);
    }

    function onFailed(error) {
      console.log(`Download failed: ${error}`);
    }
    const blob = this.toBlob()
    const url = URL.createObjectURL(blob);
    const downloading = browser.downloads.download({
      url : url,
      filename : filename? filename : `kw_report_${new Date().getTime()}.csv`,
      conflictAction : 'uniquify'
    });

    downloading.then(onStartedDownload, onFailed);
  }

}