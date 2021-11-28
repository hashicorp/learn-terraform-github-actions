import {readFileSync} from 'fs'
import { browser } from 'webextension-polyfill-ts';

export enum DOMAIN  {
  GLP = 'glp',
  YHS = 'yhs'
}

export type Ad =  {
  domain: string
  title? : string
  url?: string
}

export interface HandlerBase {
  getScript(): string
  getAdsFromPage(tabId: number): Promise<{kw: string, ads: Array<Ad>}>
}

export class GLPHandler implements HandlerBase {
  constructor() {
  }

  getAdsFromPage(tabId: number): Promise<{kw: string, ads: Array<Ad>}> {
    return new Promise<{kw: string, ads: Array<Ad>}>(((resolve, reject) => {
      function onExecuted(result: any) {
        let resultsFromPage : {kw: string, ads: Array<Ad>} = result[0];
        console.log(`resultsFromPage -> ${JSON.stringify(resultsFromPage)}`);
        console.log(`onExecuted result for kw ${resultsFromPage.kw} --> ${JSON.stringify(resultsFromPage.ads)}`)
        resolve(resultsFromPage)
      }

      function onError(error) {
        console.log(`Error: ${JSON.stringify(error)} , `);
        console.log(`Error: ${error} , `);
        reject(error)
      }

      let script = this.getScript();
      const executing = browser.tabs.executeScript(tabId,{
        code: script
      });
      executing.then(onExecuted, onError);
    }))

  }

  getScript(): string {
    return readFileSync('./src/browseraction/scrappers/glp.js').toString();
  }
}