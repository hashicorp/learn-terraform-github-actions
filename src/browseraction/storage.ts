import { browser } from 'webextension-polyfill-ts';

export enum StorageKey {
  kws = 'txt',
  preserve = 'preserve',
  closeTabs = 'closeTabs',
}

export interface StoredOptions {
  [StorageKey.kws]: string;
  [StorageKey.preserve]: boolean;
  [StorageKey.closeTabs]: boolean;
}

export async function getStoredOptions(): Promise<StoredOptions> {
  const txtVal = await browser.storage.local.get(StorageKey.kws);
  const preserveVal = await browser.storage.local.get(StorageKey.preserve);
  const closeTabsVal = await browser.storage.local.get(StorageKey.closeTabs);

  return {
    txt: txtVal?.txt || '',
    preserve: preserveVal?.preserve || false,
    closeTabs: closeTabsVal?.closeTabs || false,
  };
}

export async function storeValue<T>(key: StorageKey, value: T): Promise<void> {
  await browser.storage.local.set({ [key]: value });
}
