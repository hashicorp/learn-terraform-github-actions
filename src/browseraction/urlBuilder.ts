import { SiteOptions } from './index';

const baseGlpDomain = 'https://glp.search.yahoo.com';
const baseYhsDomain = 'https://search.yahoo.com';

export class UrlBuilder {

  urlParams = new URLSearchParams();

  constructor(public keyword: string) {
    this.urlParams.set('p', keyword);
    this.urlParams.set('hspart', 'yahoo');
  }

  addUrlParam(key, val) {
    this.urlParams.set(key, val);
  }

  getFinalUrl(domain: 'glp' | 'yhs', page?: string, sourceTag?: string): string {
    let finalUrl: URL;
    switch (domain) {
      case 'glp':
        finalUrl = new URL(baseGlpDomain);
        if (page) {
          finalUrl.pathname = page;
        }
        break;
      case 'yhs':
        finalUrl = new URL(baseYhsDomain);
        finalUrl.pathname = '/yhs/search';
        break;
      default:
        throw new Error(`No domain config for ${domain}`);
    }
    if (sourceTag) {
      this.urlParams.set('hsimp', sourceTag);
    }
    finalUrl.search = this.urlParams.toString();
    return finalUrl.href;
  }
}

export class UrlHelper {
  getFinalUrls(keywords: Array<string>, domain: 'glp' | 'yhs', options?: SiteOptions) : Array<string> {
    console.log(`getFinalUrls options -> ${JSON.stringify(options)}`);
    return keywords.map(kw => {
      let builder = new UrlBuilder(kw.trim());
      return builder.getFinalUrl(domain, options?.page, options?.sourceTag || 'yhs-fo10')
    });
  }
}
