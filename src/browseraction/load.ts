import { browser } from 'webextension-polyfill-ts';
import { Ad, GLPHandler } from './handlers';
import { CsvBuilder } from './csv';
import { TabOptions } from './index';


const getUrlByDomain = (domain): string => {
  switch (domain) {
    case 'yhs' :
      return 'https://search.yahoo.com/yhs/search?';
    case 'glp' :
      return 'glp.search.yahoo.com/as/10.html';
    default:
      return 'glp.search.yahoo.com';
  }
};

/**
 * Loads sites in new background tabs
 */
export function loadSites(urls: Array<string>, options?: TabOptions): void {
  const promises = [];
  for (let i = 0; i < urls.length; i++) {
    promises.push(new Promise<any>((resolve, reject) => {
      browser.tabs.create({
        url: urls[i],
        active: false,
      }).then(tab => {
        setTimeout(() => {
          console.log(`${tab.id} Start scrapping `);
          let id = tab.id;
          let glpHandler = new GLPHandler();
          glpHandler.getAdsFromPage(id).then((res) => {
            if (options?.closeTab) {
              browser.tabs.remove(id);
            }
            resolve(res);
          });
        }, 5000);
      });
    }));
  }
  Promise.all(promises).then((values: [{ ads: Array<Ad>, kw: string }]) => {
    let csvBuilder = new CsvBuilder();
    for (const value of values) {
      let websitesNames = value.ads.map(ad => {
        return ad.domain.replace(/.+\/\/|www.|\..+/g, '');
      });
      csvBuilder.addRecord({
        kw: value.kw,
        ads: value.ads.length,
        websites: Array.from(new Set(websitesNames)).join(', '), // remove duplicates
        domains: value.ads.map(ad => ad.domain),
      });
    }
    csvBuilder.downloadCsv();
  });
}

