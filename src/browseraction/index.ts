import { loadSites } from './load';
import { getStoredOptions, StorageKey, storeValue } from './storage';
import { getUIDef } from './ui';
import { UrlHelper } from './urlBuilder';

export {};
global.Buffer = global.Buffer || require('buffer').Buffer;

async function saveKwsList(): Promise<void> {
  const ui = getUIDef();
  if (ui.preserveCheckbox.checked) {
    await storeValue<string>(StorageKey.kws, ui.txtArea.value);
  }
}

export type SiteOptions = {
  sourceTag? : string
  page? : string
}

export type TabOptions = {
  closeTab : boolean
}

export async function init(): Promise<void> {
  const ui = getUIDef();

  // restore options
  const options = await getStoredOptions();
  console.log(`Options getStoredOptions() ${options}`);
  ui.txtArea.value = options.txt;
  ui.preserveCheckbox.checked = options.preserve;
  ui.closeTabs.checked = options.closeTabs;
  console.log(`ui ${JSON.stringify(ui)}`)
  // add button events
  let urlHelper = new UrlHelper();
  ui.openButton.addEventListener('click', () => {
    saveKwsList();
    // @ts-ignore
    let finalUrls = urlHelper.getFinalUrls(ui.txtArea.value?.split(','), ui.domain.value, {
      sourceTag: ui.sourceTag.value,
      page: ui.page.value
    });
    console.log(`ui.closeTabs.checked ${ui.closeTabs.checked}`);
    loadSites(finalUrls, {closeTab : ui.closeTabs.checked});
  });

  //*** Listeners ***
  // add options events
  ui.txtArea.addEventListener('change', saveKwsList);
  ui.preserveCheckbox.addEventListener('change', (event) => {
    const isChecked = (<HTMLInputElement>event.target).checked;
    storeValue<boolean>(StorageKey.preserve, isChecked);
    storeValue<string>(StorageKey.kws, isChecked ? ui.txtArea.value : '');
  });

  ui.closeTabs.addEventListener('change', (event) => {
    const isChecked = (<HTMLInputElement>event.target).checked;
    console.log(`ui.closeTabs.addEventListener is isChecked? ${isChecked}` );
    storeValue<boolean>(StorageKey.closeTabs, isChecked);
  });

  ui.domain.addEventListener('change', (event) => {
    const domain = (<HTMLInputElement>event.target).value;
    ui.page.hidden = domain !== 'glp';
  });

  // select text in form field
  ui.txtArea.select();
}

document.addEventListener('DOMContentLoaded', init);
