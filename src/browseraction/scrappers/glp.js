const result = {kw : '', ads: []};
const adsQuery = 'div.da.odd,div.da.even';

const urlSearchParams = new URLSearchParams(document.location.search);
const kw = urlSearchParams.get('p') || urlSearchParams.get('st')
result.kw = kw
const adsContainer = document.querySelector('#entitiesContainerSRP');
const ads = adsContainer.querySelectorAll(adsQuery);
for (let i = 0; i < ads.length; i++) {
  const ad = ads[i];
  let domain = ad.getElementsByClassName('pDisplayUrl')[0].textContent;
  let title = ad.getElementsByClassName('pTitle')[0].textContent;
  let url = ad.querySelector('a').href;
  result.ads.push({domain, title, url });
}


result;